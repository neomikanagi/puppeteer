# 使用 Puppeteer 官方基础镜像
FROM satantime/puppeteer-node:20-slim

# 切换到应用工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json（如果有）
COPY package*.json ./

# 安装 Puppeteer（不自动下载 Chromium）
ENV PUPPETEER_SKIP_DOWNLOAD=true

# 安装 Puppeteer，但不下载默认的 Chromium
RUN npm install puppeteer

# 下载合适的 Chromium 浏览器
RUN case "$(uname -m)" in \
    "x86_64") \
        echo "Detected amd64 architecture"; \
        apt-get update && apt-get install -y chromium; \
        ;; \
    "aarch64") \
        echo "Detected arm64 architecture"; \
        apt-get update && apt-get install -y chromium; \
        ;; \
    "armv7l") \
        echo "Detected armv7 architecture"; \
        apt-get update && apt-get install -y chromium; \
        ;; \
    *) \
        echo "Unknown architecture"; \
        exit 1; \
        ;; \
    esac

# 复制应用代码
COPY . .

# 设置 Puppeteer 使用已安装的 Chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

