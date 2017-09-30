#!/usr/bin/env bash
if [ -f "/usr/sbin/ss5"  ] || [  -f "usr/bin/ss5" ];then
    echo 'ss5 has install'
else
    yum -y install gcc gcc-c++ automake make pam-devel openldap-devel cyrus-sasl-devel  openssl-devel
    wget -c http://dailichi.oss-cn-hangzhou.aliyuncs.com/ss5-3.8.9.zip
    unzip ss5-3.8.9.zip
    cd ss5-3.8.9
    chmod 777 -R ./*
    ./configure
    make && make install

fi

file="/etc/opt/ss5/ss5.conf"
echo '
#      Auth     SHost           SPort   DHost           DPort   Fixup   Group   Band    ExpDate
#
permit -       0.0.0.0/0       -       0.0.0.0/0       -       -       -       -       -

#       SHost           SPort           Authentication
#
auth    0.0.0.0/0               -               -
' > ${file}

#ss5 -u root -b 0.0.0.0:9999

#LIBS = -lpthread -rdynamic -ldl -lssl -lldap -lpam -lpam_misc -L/lib64 -lcrypto