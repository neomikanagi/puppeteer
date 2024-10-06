FROM node:20

# Configure default locale (important for chrome-headless-shell).
ENV LANG en_US.UTF-8

# Install latest chrome dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
RUN apt-get update \
    && apt-get install -f -y \
    && apt-get install -y --no-install-recommends chromium-browser \
    fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-khmeros \
    fonts-kacst fonts-freefont-ttf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add pptruser.
RUN groupadd -r pptruser && useradd -rm -g pptruser -G audio,video pptruser

USER pptruser

WORKDIR /home/pptruser

# 安装 Puppeteer
RUN npm install puppeteer

USER root

# 切换回 pptruser 用户
USER pptruser
