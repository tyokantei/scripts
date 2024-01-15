if [ ! $2 ]; then
	xiaoya_config="/etc/xiaoya"
else
	xiaoya_config=$2
fi

mkdir -p $xiaoya_config/resilio/downloads

if [ $1 ]; then
docker run -d \
  -m 4096M \
  --log-driver none \
  --name=resilio \
  -e PUID=0 \
  -e PGID=0 \
  -e TZ=Asia/Shanghai \
  -p 8888:8888 \
  -p 55555:55555 \
  -v $xiaoya_config/resilio:/config \
  -v $xiaoya_config/resilio/downloads:/downloads \
  -v $1:/sync \
  --restart=always \
  lscr.io/linuxserver/resilio-sync:latest
else
	echo "请在命令后输入 -s /媒体库目录 再重试"
	exit 1
fi

