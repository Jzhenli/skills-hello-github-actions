# FROM arm32v7/python:3.9-buster

# # 安装Nuitka
# RUN pip install nuitka

# # 设置工作目录
# WORKDIR /app

# # 将你的代码放到容器中
# COPY . /app

# # 编译你的Python应用
# RUN nuitka --standalone --onefile --output-dir=build hello.py

# # 设置入口点
# CMD ["build/hello"]


# 使用ARM架构的Python基础镜像
FROM arm32v7/python:3.9-buster

# 设置工作目录
WORKDIR /app

# 复制代码到容器中
COPY hello.py .

# 更新包列表并安装依赖项
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    build-essential \
    python3-dev \
    && pip install --no-cache-dir nuitka \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 编译Python文件
CMD ["nuitka", "--output-dir=output", "--standalone", "--onefile", "hello.py"]