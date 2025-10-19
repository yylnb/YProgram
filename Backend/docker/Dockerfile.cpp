# 基于 GCC 镜像
FROM gcc:12.2.0

WORKDIR /code

# 非 root 用户
USER nobody:nogroup