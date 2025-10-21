// friends.js
/**
 * 好友及好友请求模块
 * @param {import('mysql2/promise').Pool} pool
 * @param {Function} authMiddleware
 */
const express = require('express');

function parseIdsParam(str) {
  if (!str) return [];
  return String(str).split(',').map(s => Number(s.trim())).filter(n => !Number.isNaN(n) && n > 0);
}

module.exports = (pool, authMiddleware) => {
  const router = express.Router();

  // ---------- 获取好友列表 ----------
  // GET /           -> mounted at /api/friends
  router.get('/', authMiddleware, async (req, res) => {
    const userId = Number(req.user && req.user.id);
    if (!userId) return res.status(401).json({ error: '未登录' });

    try {
      const [rows] = await pool.query(
        `SELECT u.id, u.username, u.created_at
         FROM friends f
         JOIN users u ON (CASE WHEN f.user_id = ? THEN f.friend_id ELSE f.user_id END) = u.id
         WHERE f.user_id = ? OR f.friend_id = ?
         ORDER BY f.created_at DESC`,
        [userId, userId, userId]
      );
      res.json(rows);
    } catch (err) {
      console.error('GET /friends error', err);
      res.status(500).json({ error: '获取好友失败' });
    }
  });

  // ---------- 批量检查关系状态（前端在一批 search results 上标记） ----------
  // GET /statuses?ids=1,2,3
  router.get('/statuses', authMiddleware, async (req, res) => {
    try {
      const me = Number(req.user.id);
      const ids = parseIdsParam(req.query.ids || req.query.ids_list || req.query.q || req.query.ids);
      if (!ids.length) return res.json([]);

      const uniqueIds = Array.from(new Set(ids)).filter(i => i !== me);
      if (!uniqueIds.length) return res.json([]);

      const placeholders = uniqueIds.map(() => '?').join(',');

      // 1) friends
      const [friendsRows] = await pool.query(
        `SELECT user_id, friend_id FROM friends
         WHERE (user_id = ? AND friend_id IN (${placeholders}))
            OR (friend_id = ? AND user_id IN (${placeholders}))`,
        [me, ...uniqueIds, me, ...uniqueIds]
      );

      // 2) pending sent
      const [pendingSentRows] = await pool.query(
        `SELECT to_id AS id, id AS requestId FROM friend_requests WHERE from_id = ? AND to_id IN (${placeholders}) AND status = 'pending'`,
        [me, ...uniqueIds]
      );

      // 3) pending received
      const [pendingRecvRows] = await pool.query(
        `SELECT from_id AS id, id AS requestId FROM friend_requests WHERE to_id = ? AND from_id IN (${placeholders}) AND status = 'pending'`,
        [me, ...uniqueIds]
      );

      const friendSet = new Set(friendsRows.map(r => (r.user_id === me ? r.friend_id : r.user_id)));
      const sentMap = new Map(pendingSentRows.map(r => [r.id, r.requestId]));
      const recvMap = new Map(pendingRecvRows.map(r => [r.id, r.requestId]));

      const result = uniqueIds.map(id => {
        if (friendSet.has(id)) return { id, status: 'accepted' };
        if (sentMap.has(id)) return { id, status: 'pending_sent', requestId: sentMap.get(id) };
        if (recvMap.has(id)) return { id, status: 'pending_received', requestId: recvMap.get(id) };
        return { id, status: 'none' };
      });

      return res.json(result);
    } catch (err) {
      console.error('GET /friends/statuses error', err);
      res.status(500).json({ error: '检查关系状态失败' });
    }
  });

  // ---------- 发送好友请求（from = 当前用户） ----------
  // POST /request  body: { toUserId } or { to_id } or { toId }
  router.post('/request', authMiddleware, async (req, res) => {
    const fromId = Number(req.user.id);
    const toUserId = Number(req.body.toUserId ?? req.body.to_id ?? req.body.toId);

    if (!fromId) return res.status(401).json({ error: '未登录' });
    if (!toUserId) return res.status(400).json({ error: 'toUserId 必须提供' });
    if (toUserId === fromId) return res.status(400).json({ error: '不能添加自己为好友' });

    try {
      // 检查目标用户存在
      const [uRows] = await pool.query('SELECT id FROM users WHERE id = ? LIMIT 1', [toUserId]);
      if (!uRows.length) return res.status(404).json({ error: '目标用户不存在' });

      // 检查是否已是好友
      const [fRows] = await pool.query(
        `SELECT id FROM friends WHERE (user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?) LIMIT 1`,
        [fromId, toUserId, toUserId, fromId]
      );
      if (fRows.length) return res.status(400).json({ error: '你们已经是好友' });

      // 检查最近的一条 request（同向 from->to）
      const [rRows] = await pool.query(
        `SELECT id, status FROM friend_requests WHERE from_id = ? AND to_id = ? ORDER BY id DESC LIMIT 1`,
        [fromId, toUserId]
      );

      if (rRows.length) {
        const st = rRows[0].status;
        if (st === 'pending') {
          return res.status(400).json({ error: '请求已存在（待对方处理）' });
        }
        if (st === 'accepted') {
          return res.status(400).json({ error: '你们已经是好友' });
        }
        if (st === 'rejected') {
          // 重发：更新最近一条为 pending（可改为插入新记录以保留记录）
          await pool.query('UPDATE friend_requests SET status = ?, updated_at = NOW() WHERE id = ?', ['pending', rRows[0].id]);
          return res.json({ message: '好友请求已重新发送' });
        }
      }

      // 插入新 pending 请求
      const [r] = await pool.query('INSERT INTO friend_requests (from_id, to_id, status) VALUES (?, ?, ?)', [fromId, toUserId, 'pending']);
      return res.json({ message: '好友请求已发送', requestId: r.insertId });
    } catch (err) {
      console.error('POST /friends/request error', err);
      res.status(500).json({ error: '发送好友请求失败' });
    }
  });

  // ---------- 获取收到的好友请求（pending） ----------
  // GET /requests
  router.get('/requests', authMiddleware, async (req, res) => {
    try {
      const userId = Number(req.user.id);
      const [rows] = await pool.query(
        `SELECT fr.id, fr.from_id, u.username, fr.status, fr.created_at, fr.updated_at
         FROM friend_requests fr
         JOIN users u ON u.id = fr.from_id
         WHERE fr.to_id = ? AND fr.status = 'pending'
         ORDER BY fr.created_at DESC`,
        [userId]
      );
      res.json(rows);
    } catch (err) {
      console.error('GET /friends/requests error', err);
      res.status(500).json({ error: '获取好友请求失败' });
    }
  });

  // ---------- 搜索用户（兼容 q 或 keyword） ----------
  // GET /search?q=xxx
  router.get('/search', authMiddleware, async (req, res) => {
    try {
      const q = (req.query.q || req.query.keyword || '').trim();
      if (!q) return res.json([]);

      if (/^\d+$/.test(q)) {
        const [rows] = await pool.query('SELECT id, username FROM users WHERE id = ? LIMIT 1', [Number(q)]);
        return res.json(rows);
      } else {
        const like = `%${q}%`;
        const [rows] = await pool.query('SELECT id, username FROM users WHERE username LIKE ? LIMIT 50', [like]);
        return res.json(rows);
      }
    } catch (err) {
      console.error('GET /friends/users/search error', err);
      res.status(500).json({ error: '用户搜索失败' });
    }
  });

  // ---------- 处理好友请求（接受或拒绝） ----------
  // POST /respond  body: { requestId, accept: true|false }
  router.post('/respond', authMiddleware, async (req, res) => {
    const userId = Number(req.user.id);
    const requestId = Number(req.body.requestId);
    const accept = !!req.body.accept;

    if (!userId) return res.status(401).json({ error: '未登录' });
    if (!requestId) return res.status(400).json({ error: 'requestId 必须提供' });

    try {
      const [rows] = await pool.query('SELECT * FROM friend_requests WHERE id = ? LIMIT 1', [requestId]);
      if (!rows.length) return res.status(404).json({ error: '请求不存在' });
      const reqRow = rows[0];

      if (Number(reqRow.to_id) !== userId) return res.status(403).json({ error: '无权处理该请求' });

      if (!accept) {
        await pool.query('UPDATE friend_requests SET status = ?, updated_at = NOW() WHERE id = ?', ['rejected', requestId]);
        return res.json({ message: '已拒绝好友请求' });
      }

      // 接受：事务处理
      const conn = await pool.getConnection();
      try {
        await conn.beginTransaction();

        const fromId = Number(reqRow.from_id);
        const toId = Number(reqRow.to_id);

        // 并发检查是否已为好友
        const [already] = await conn.query(
          `SELECT id FROM friends WHERE (user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?) LIMIT 1`,
          [fromId, toId, toId, fromId]
        );

        // 更新请求为 accepted
        await conn.query('UPDATE friend_requests SET status = ?, updated_at = NOW() WHERE id = ?', ['accepted', requestId]);

        if (!already.length) {
          await conn.query('INSERT INTO friends (user_id, friend_id) VALUES (?, ?)', [fromId, toId]);
        }

        await conn.commit();
        conn.release();
        return res.json({ message: '好友请求已同意' });
      } catch (txErr) {
        await conn.rollback();
        conn.release();
        console.error('transaction respond error', txErr);
        return res.status(500).json({ error: '处理请求失败' });
      }
    } catch (err) {
      console.error('POST /friends/respond error', err);
      res.status(500).json({ error: '处理好友请求失败' });
    }
  });

  // ---------- 删除好友（任一方向） ----------
  // DELETE /:id   (mounted at /api/friends/:id)
  router.delete('/:id', authMiddleware, async (req, res) => {
    try {
      const userId = Number(req.user.id);
      const friendId = Number(req.params.id);
      if (!friendId || friendId === userId) return res.status(400).json({ error: '非法好友 ID' });

      const [result] = await pool.query(
        `DELETE FROM friends WHERE (user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)`,
        [userId, friendId, friendId, userId]
      );

      if (result.affectedRows === 0) {
        return res.status(404).json({ error: '未找到好友关系' });
      }
      return res.json({ success: true });
    } catch (err) {
      console.error('DELETE /friends/:id error', err);
      res.status(500).json({ error: '删除好友失败' });
    }
  });

  return router;
};
