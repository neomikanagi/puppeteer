FROM node:20

# Configure default locale (important for chrome-headless-shell).
ENV LANG en_US.UTF-8

# Install latest chrome dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
RUN apt-get update \
    && apt-get install -y --no-install-recommends fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-khmeros \
    fonts-kacst fonts-freefont-ttf

# Add pptruser.
RUN groupadd -r pptruser && useradd -rm -g pptruser -G audio,video pptruser

USER pptruser

WORKDIR /home/pptruser

# 安装 Puppeteer 及其浏览器依赖
RUN npm install puppeteer \
    && npx puppeteer browsers install chrome --install-deps

USER root

# 返回 pptruser
USER pptruser
