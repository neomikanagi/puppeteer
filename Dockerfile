FROM node:20@sha256:fffa89e023a3351904c04284029105d9e2ac7020886d683775a298569591e5bb

# 设置默认语言环境
ENV LANG en_US.UTF-8

# 安装 Puppeteer 运行所需的字体和系统依赖
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-khmeros \
    fonts-kacst fonts-freefont-ttf dbus dbus-x11 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 添加用户 pptruser
RUN groupadd -r pptruser && useradd -rm -g pptruser -G audio,video pptruser

USER pptruser

WORKDIR /home/pptruser

# 安装 Puppeteer
RUN npm install puppeteer

# 验证 Puppeteer 是否正确安装 Chromium
RUN node -e "console.log(require('puppeteer').executablePath())"

USER root
# 注释掉手动安装浏览器依赖的步骤
# RUN npx puppeteer browsers install chrome --install-deps

USER pptruser
