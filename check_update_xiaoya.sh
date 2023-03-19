#!/bin/sh

# 把该sh 文件放进 默认的/etc/xiaoya（自定义的都需要修改路径） 下面，手动就在终端下运行：sh /etc/xiaoya/check_update_xiaoya.sh
# 计划任务 0 */4 * * * /etc/xiaoya/check-update_xiaoya.sh  >/tmp/checkxiaoya.log   （我是openwrt，各位看着自己修改）
# Check if there is a newer image available 检查pull命令的输出中是否包含字符串"Downloaded newer image"，如果包含，就认为存在更新的镜像可用
if [ "$(docker pull xiaoyaliu/alist:latest 2>&1 | grep -c 'Downloaded newer image')" -eq 0 ]; then
    echo "Remote image is not newer. Not updating.已经最新，无须更新"
    exit
fi

# Stop and remove existing container 
docker stop xiaoya
docker rm xiaoya

# Remove old token file if it exists
if [ -d /etc/xiaoya/mytoken.txt ]; then
    rm -rf /etc/xiaoya/mytoken.txt
fi

# Create necessary directories and files
mkdir -p /etc/xiaoya
touch /etc/xiaoya/mytoken.txt
touch /etc/xiaoya/pikpak.txt
touch /etc/xiaoya/guestpass.txt
touch /etc/xiaoya/myopentoken.txt
touch /etc/xiaoya/temp_transfer_folder_id.txt

# Check if necessary files exist and are not empty
if [[ ! -s /etc/xiaoya/mytoken.txt ]] || [[ ! -s /etc/xiaoya/myopentoken.txt ]] || [[ ! -s /etc/xiaoya/temp_transfer_folder_id.txt ]]; then
    echo -e "请配置三个必须文件后再执行安装: \n/etc/xiaoya/mytoken.txt \n/etc/xiaoya/myopentoken.txt \n/etc/xiaoya/temp_transfer_folder_id.txt \n安装停止，请参考指南配置文件\nhttps://xiaoyaliu.notion.site/xiaoya-docker-69404af849504fa5bcf9f2dd5ecaa75f \n"
    exit
fi

# Run new container with latest image
docker run -d -p 5678:80 -v /etc/xiaoya:/data --restart=always --name=xiaoya xiaoyaliu/alist:latest
echo "xiaoya 镜像已更新并重启成功！"
