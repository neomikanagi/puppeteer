# 使用官方 Puppeteer 镜像
FROM ghcr.io/puppeteer/puppeteer:latest

# 设置工作目录
WORKDIR /usr/src/app

# 复制 package.json 和 package-lock.json 并安装依赖
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 复制项目代码
COPY . .
