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

# 设置环境变量，配置 DBUS 地址
ENV DBUS_SESSION_BUS_ADDRESS autolaunch:

# 切换到 root 用户，安装 Puppeteer 的系统依赖
USER root
RUN npx puppeteer browsers install chrome --install-deps

USER pptruser

# 验证 Chromium 是否正确安装
RUN node -e "console.log(require('puppeteer').executablePath())"

# 注释掉生成第三方许可文件的部分，避免报错
# RUN node -e "require('child_process').execSync(require('puppeteer').executablePath() + ' --credits', {stdio: 'inherit'})" > THIRD_PARTY_NOTICES
