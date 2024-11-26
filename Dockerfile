# 使用适合树莓派2的镜像
FROM balenalib/raspberrypi2-alpine:latest

# 更新包列表并安装必要的依赖
RUN apk add --no-cache \
    build-base \
    python3-dev \
    py3-pip

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