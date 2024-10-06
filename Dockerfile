FROM satantime/puppeteer-node:20-slim

# 切换到应用工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json（如果有）
COPY package*.json ./

# 安装 Puppeteer（你可以指定所需版本）
RUN npm install puppeteer

# 复制你的应用代码
COPY . .
