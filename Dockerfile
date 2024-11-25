# 声明基础镜像，可以选择合适的 Python 镜像
FROM python:3.9-slim

# 安装 Nuitka
RUN apt-get update && \
    apt-get install -y gcc g++ && \
    pip install nuitka

# 将当前目录的代码复制到容器中
COPY . /src
WORKDIR /src

# 编译 Python 程序为 ARM 二进制文件
CMD ["nuitka", "--follow-imports", "--output-dir=./output", "hello_world.py"]