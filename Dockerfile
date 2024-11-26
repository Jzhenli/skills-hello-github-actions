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

# 安装编译所需的依赖
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    build-essential \
    python3-dev \
    libpython3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN pip install --no-cache-dir nuitka

# 设置工作目录
WORKDIR /app

# 复制你的源代码到容器内
COPY hello.py .

# 安装Nuitka
RUN pip install nuitka

# 编译Python文件
CMD ["nuitka", "--output-dir=output", "--standalone", "--onefile", "hello.py"]