#!/bin/bash

# ���/toolĿ¼�Ƿ����
if [ ! -d "/tool" ]; then
  # ���/toolĿ¼�����ڣ��ʹ���
  mkdir /tool
  echo "����/toolĿ¼"
else
  echo "/toolĿ¼�Ѿ�����"
fi

# ����115pushĿ¼
if [ ! -d "/tool/115push" ]; then
  mkdir /tool/115push
  echo "����/tool/115pushĿ¼"
else
  echo "/tool/115pushĿ¼�Ѿ�����"
fi

# ���cookie.txt�Ƿ���ڻ�Ϊ��
if [ ! -s "/tool/115push/cookie.txt" ]; then
  echo "�뵼��115С���˵�ck��ʽ����editcookie����clouddrive2��ck��ʽ�����浽/tool/115push/cookie.txt�ļ���"
else
  echo "/tool/115push/cookie.txt�Ѿ����ڣ����ļ����ݷǿ�"
fi

# ����115push�ű�
if [ ! -f "/tool/115push/115push" ]; then
  wget -O /tool/115push/115push https://github.com/tyokantei/scripts/blob/master/115push_linux_amd64?raw=true
  chmod 755 /tool/115push/115push
  echo "����115push�ű���/tool/115pushĿ¼"
else
  echo "/tool/115push/115push�Ѿ�����"
fi

# ����һ��ִ�нű�
if [ ! -f "/115pushX86.sh" ]; then
  cat > /115pushX86.sh <<'EOF'
#!/bin/bash
cd /tool/115push
./115push
EOF
  chmod +x /115pushX86.sh
  echo "����115pushX86.sh�ű�"
else
  echo "115pushX86.sh�ű��Ѿ�����"
fi

echo "��ɣ�"


