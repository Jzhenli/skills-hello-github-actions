FROM arm32v7/python:3.9-buster

# 安装Nuitka
RUN pip install nuitka

# 设置工作目录
WORKDIR /app

# 将你的代码放到容器中
COPY . /app

# 编译你的Python应用
RUN nuitka --standalone --onefile --output-dir=build hello.py

# 设置入口点
CMD ["build/hello"]