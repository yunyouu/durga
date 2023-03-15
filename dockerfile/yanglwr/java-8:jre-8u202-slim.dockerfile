FROM lwieske/java-8:jre-8u202-slim

# 设置时区为 Asia/Shanghai
RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone \
    && apk del tzdata

# 安装 glibc 库和生成中文 UTF-8 编码支持
RUN apk add --no-cache ca-certificates wget curl bash \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk \
        https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-bin-2.25-r0.apk \
        https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-i18n-2.25-r0.apk \
    && apk add --no-cache --allow-untrusted glibc-bin-2.25-r0.apk glibc-i18n-2.25-r0.apk glibc-2.25-r0.apk \
    && rm /etc/apk/keys/sgerrand.rsa.pub \
    && rm glibc-2.25-r0.apk glibc-bin-2.25-r0.apk glibc-i18n-2.25-r0.apk \
    && /usr/glibc-compat/bin/localedef -i zh_CN -f UTF-8 zh_CN.UTF-8 \
    && rm -rf /var/cache/apk/*

ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8