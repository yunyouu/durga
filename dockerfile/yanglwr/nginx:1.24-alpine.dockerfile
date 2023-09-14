FROM nginx:1.24-alpine

# 基于 nginx:1.24-alpine 重新构建，添加中文支持、调整时区为 Asia/Shanghai，添加
MAINTAINER yanglwr <keepging@outlook.com>

RUN echo -e "\
en_US\n\
zh_CN\
" > /locale.md

RUN apk update \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone \
    && apk del tzdata \
    && apk --no-cache add ca-certificates wget \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk \
        https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-bin-2.25-r0.apk \
        https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-i18n-2.25-r0.apk \
    && apk add glibc-bin-2.25-r0.apk glibc-i18n-2.25-r0.apk glibc-2.25-r0.apk \
    && sleep 3 \
    && cat /locale.md | xargs -i /usr/glibc-compat/bin/localedef -i {} -f UTF-8 {}.UTF-8 \
    && rm /etc/apk/keys/sgerrand.rsa.pub \
    && rm /locale.md \
        glibc-2.25-r0.apk \
        glibc-bin-2.25-r0.apk \
        glibc-i18n-2.25-r0.apk \
    && apk del wget  ca-certificates\
    && rm -rf /var/cache/apk/* \
    && rm "/root/.wget-hsts"

ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8

RUN echo -e "server {\n\
            listen 80;\n\
            gzip on;\n\ 
            gzip_buffers 32 4k;\n\
            gzip_comp_level 6;\n\
            gzip_min_length 200;\n\
            gzip_types text/css text/xml application/javascript;\n\
            gzip_vary on;\n\
            location / {\n\
                add_header Access-Control-Allow-Methods *;\n\
                add_header Access-Control-Allow-Origin \$http_origin;\n\
                add_header Cache-Control 'no-cache, must-revalidate, proxy-revalidate, max-age=0';\n\
                root /usr/share/nginx/html;\n\
                index index.html index.htm;\n\
                try_files \$uri \$uri/ /index.html =404;\n\
            }\n\
        }" > /etc/nginx/conf.d/default.conf
