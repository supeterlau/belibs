FROM nginx:alpine

# as ROOT
COPY ./apt/sources.list /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -y vim man zsh less
