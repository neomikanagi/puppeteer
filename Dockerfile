# 使用 Node.js LTS 版本的 Alpine 基础镜像
FROM node:lts-alpine

# 安装 Chromium 及其依赖
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    bash

# 设置 Puppeteer 环境变量，防止下载 Chromium，并指定路径
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# 设置工作目录
WORKDIR /usr/src/app

# 复制 package.json 和 package-lock.json 并安装依赖

# 清理 npm 缓存以防止问题
RUN npm cache clean --force

# 使用 --unsafe-perm 选项运行 npm install 避免权限问题
COPY package*.json ./
RUN npm install --unsafe-perm

# 复制所有项目文件
COPY . .

# 默认的入口点，但没有指定具体的 CMD
ENTRYPOINT ["node"]

# 允许在运行时通过命令行传递要运行的脚本
CMD []
