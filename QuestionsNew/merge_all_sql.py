import os

# ================= 配置区 =================
BASE_DIR = r"F:\project\YProgram\QuestionsNew\python1_insertTEST_from_json"
OUTPUT_FILE = r"F:\project\YProgram\QuestionsNew\ALL_UNITS_final.sql"

# stage 文件夹顺序（非常重要）
STAGES = ["stage1", "stage2", "stage3", "stage4", "stage5"]

# 是否在每个 unit 之间加分隔注释
ADD_SEPARATOR = True


def merge_sql_files():
    sql_blocks = []
    sql_blocks.append("-- =====================================")
    sql_blocks.append("-- AUTO MERGED SQL FILE")
    sql_blocks.append("-- =====================================\n")

    for stage in STAGES:
        stage_path = os.path.join(BASE_DIR, stage)
        if not os.path.exists(stage_path):
            print(f"⚠️ 跳过不存在的目录: {stage_path}")
            continue

        sql_blocks.append(f"\n-- ========== {stage.upper()} ==========\n")

        # 按文件名排序（unit1.sql, unit2.sql ...）
        files = sorted(
            [f for f in os.listdir(stage_path) if f.endswith(".sql")],
            key=lambda x: int("".join(filter(str.isdigit, x)) or 0)
        )

        for filename in files:
            file_path = os.path.join(stage_path, filename)
            print(f"📄 合并: {file_path}")

            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read().strip()

            if not content:
                continue

            if ADD_SEPARATOR:
                sql_blocks.append(f"\n-- -------- {stage}/{filename} --------")

            sql_blocks.append(content)
            sql_blocks.append("")  # 空行

    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_blocks))

    print("\n✅ 所有 SQL 已合并完成！")
    print(f"📦 输出文件: {OUTPUT_FILE}")


if __name__ == "__main__":
    merge_sql_files()