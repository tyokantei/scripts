#!/bin/bash

# 停止并删除已存在的容器
if [ "$(docker ps -q -f name=aliyundrive-subscribe)" ]; then
    docker stop aliyundrive-subscribe
fi
if [ "$(docker ps -qa -f name=aliyundrive-subscribe)" ]; then
    docker rm aliyundrive-subscribe
fi

# 拉取最新版本的镜像并检查是否需要更新
if docker pull looby/aliyundrive-subscribe:latest | grep -q "Downloaded newer image"; then
    echo "已更新到最新版本"
else
    echo "已经是最新版本，无须更新"
fi

# 下载配置文件
config_dir=/etc/aliyundrive-subscribe/conf
config_file=$config_dir/app.ini
mkdir -p "$config_dir"
if [ ! -f "$config_file" ]; then
    curl -sSL -o "$config_file" https://ghproxy.com/https://raw.githubusercontent.com/tyokantei/scripts/master/app.ini \
        || { echo "无法下载配置文件，请手动下载并将其保存到 $config_file"; exit 1; }
fi

# 运行新容器，并通用设置
docker run -d -p 8002:8002 -v /etc/aliyundrive-subscribe/conf:/app/conf --restart=always --name=aliyundrive-subscribe looby/aliyundrive-subscribe:latest

