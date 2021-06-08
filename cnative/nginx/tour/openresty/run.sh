TAG=buster-fat

# docker run --rm -it -p 9080:80 --name resty-dev openresty/openresty:$TAG

# docker run --rm -it -p 9080:80 -v $(PWD)/conf.d:/etc/nginx/conf.d --name resty-dev openresty/openresty:$TAG

docker run --rm -it -p 9080:80 -p 9100:8080 -v $(PWD)/conf.d:/etc/nginx/conf.d -v $(PWD)/work:/root/work --name resty-dev openresty/openresty:$TAG

# docker run --rm -it openresty/openresty:$TAG


# docker run --rm -it -p 9080:80 openresty/openresty

echo "deb http://nginx.org/packages/debian `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list