# 使用适合树莓派2的镜像
FROM arm32v7/python:3.9-buster

# 更新包列表并安装必要的依赖
RUN sudo apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    python3-pip

# 安装Nuitka
RUN pip3 install nuitka

# 设置工作目录
WORKDIR /app

# 将你的代码放到容器中
COPY . /app

# 编译你的Python应用
RUN nuitka --standalone --onefile --output-dir=build hello.py

# 设置入口点
CMD ["build/hello"]