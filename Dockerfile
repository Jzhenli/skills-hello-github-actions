# 使用适合树莓派2的镜像
FROM arm32v7/python:3.9-buster

# 输出日志来检查网络状态
RUN echo "Checking network connection..."
RUN ping -c 4 google.com

# 更新包列表并安装必要的依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-pip

# 安装python3-dev
RUN apt-get install -y --no-install-recommends python3-dev

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