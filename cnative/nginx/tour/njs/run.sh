#! /bin/bash

TAG=alpine

CMD="docker run --rm -it -p 9080:80 
-v $(PWD)/nginx/conf.d:/etc/nginx/conf.d 
-v $(PWD)/nginx/nginx.conf:/etc/nginx/nginx.conf 
-v $(PWD)/web:/usr/share/nginx/html 
--name njs-dev nginx:$TAG"

echo $CMD

$CMD

# nginx 
#     conf.d 
#     nginx.conf 
# web

# docker run --rm -it -p 9080:80 -v $(PWD)/conf.d:/etc/nginx/conf.d --name njs-dev nginx:$TAG

# sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
# apk add openssl 

# printf "%s%s%s%s\n" \
#     "@nginx " \
#     "http://nginx.org/packages/alpine/v" \
#     `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
#     "/main" \
#     | tee -a /etc/apk/repositories

# curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub

# openssl rsa -pubin -in /tmp/nginx_signing.rsa.pub -text -noout

# mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/

# apk add nginx-module-njs@nginx

# https://mirrors.tuna.tsinghua.edu.cn/help/alpine/ Alpine 镜像使用帮助

# curl ca-certificates

# nginx-module-image-filter@nginx

# https://unix.stackexchange.com/questions/19124/bash-multi-line-command-with-comments-after-the-continuation-character
# https://stackoverflow.com/questions/23929235/multi-line-string-with-extra-space-preserved-indentation