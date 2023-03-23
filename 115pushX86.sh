#!/bin/bash

# 检查/tool目录是否存在
if [ ! -d "/tool" ]; then
  # 如果/tool目录不存在，就创建
  mkdir /tool
  echo "创建/tool目录"
else
  echo "/tool目录已经存在"
fi

# 创建115push目录
if [ ! -d "/tool/115push" ]; then
  mkdir /tool/115push
  echo "创建/tool/115push目录"
else
  echo "/tool/115push目录已经存在"
fi

# 检查cookie.txt是否存在或为空
if [ ! -s "/tool/115push/cookie.txt" ]; then
  echo "请导入115小幸运的ck格式或用editcookie导出clouddrive2的ck格式，保存到/tool/115push/cookie.txt文件中"
else
  echo "/tool/115push/cookie.txt已经存在，且文件内容非空"
fi

# 下载115push脚本
if [ ! -f "/tool/115push/115push" ]; then
  wget -O /tool/115push/115push https://github.com/tyokantei/scripts/blob/master/115push_linux_amd64?raw=true
  chmod 755 /tool/115push/115push
  echo "下载115push脚本到/tool/115push目录"
else
  echo "/tool/115push/115push已经存在"
fi

# 创建一键执行脚本
if [ ! -f "/115pushX86.sh" ]; then
  cat > /115pushX86.sh <<'EOF'
#!/bin/bash
cd /tool/115push
./115push
EOF
  chmod +x /115pushX86.sh
  echo "创建115pushX86.sh脚本"
else
  echo "115pushX86.sh脚本已经存在"
fi

echo "完成！"


