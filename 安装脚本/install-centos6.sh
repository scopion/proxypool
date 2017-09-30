#!/bin/bash
# 1. use adsl-setup to configuration for adsl
# 2. use adsl-start to connect

# turn off selinux and iptables
setenforce 0
sed -ri 's#SELINUX=.*#SELINUX=disabled#g' /etc/selinux/config
chkconfig iptables off
/etc/init.d/iptables -F
/etc/init.d/iptables stop
iptables -F
iptables stop

yum install wget crontabs vixie-cron ntpdate -y
wget -O /data/restartadsl.sh  http://dailichi.oss-cn-hangzhou.aliyuncs.com/restartadsl.sh
chmod +x /data/restartadsl.sh

# base YUM source repo USE aliyun
#wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo

#yum update -y

echo 'nohup ifstat -atD &' > start-nohub.sh
# install ifstat
yum groupinstall "Development tools" -y
#wget http://distfiles.macports.org/ifstat/ifstat-1.1.tar.gz
wget http://dailichi.oss-cn-hangzhou.aliyuncs.com/ifstat-1.1.tar.gz
tar xzvf ifstat-1.1.tar.gz
cd ifstat-1.1
./configure
make
make install

cd /root

# install squid
# install squid
# squidRepo='/etc/yum.repos.d/squid.repo'
# 
# rm -f ${squidRepo}
# touch ${squidRepo}
# 
# echo '[squid]' >> ${squidRepo}
# echo 'name=Squid repo for CentOS Linux - $basearch' >> ${squidRepo}
# echo '#IL mirror' >> ${squidRepo}
# echo 'baseurl=http://www1.ngtech.co.il/repo/centos/$releasever/$basearch/' >> ${squidRepo}
# echo 'failovermethod=priority' >> ${squidRepo}
# echo 'enabled=1' >> ${squidRepo}
# echo 'gpgcheck=0' >> ${squidRepo}
# yum update -y
# yum install squid -y
wget http://dailichi.oss-cn-hangzhou.aliyuncs.com/squid-3.5.20-1.el6.x86_64.rpm
yum localinstall squid-3.5.20-1.el6.x86_64.rpm -y
wget http://dailichi.oss-cn-hangzhou.aliyuncs.com/squid-config.sh && sh squid-config.sh 

wget http://dailichi.oss-cn-hangzhou.aliyuncs.com/ss5-install.sh && sh ss5-install.sh

#install telegraf
#wget https://dl.influxdata.com/telegraf/releases/telegraf-0.13.1.x86_64.rpm
#wget http://dailichi.oss-cn-hangzhou.aliyuncs.com/telegraf-0.13.1.x86_64.rpm
#yum localinstall telegraf-0.13.1.x86_64.rpm -y
#wget http://dailichi.oss-cn-hangzhou.aliyuncs.com/telegraf-conf.sh && sh telegraf-conf.sh

# jdk
#cd /usr/local/src
#wget http://wecash-resources.oss-cn-hangzhou.aliyuncs.com/jdk-8u65-linux-x64.tar.gz
#tar xf jdk-8u65-linux-x64.tar.gz -C ..
#cat >> /etc/profile <<-EOF
#export JAVA_HOME=/usr/local/jdk1.8.0_65
#export PATH=\$JAVA_HOME/bin:\$PATH
#export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
#EOF
yum install -y java-1.8.0-openjdk
#squid cut
cat > /data/squid-cut.sh <<-EOF
cd /var/log/squid
date=\`date +%Y-%m-%d\`
/usr/sbin/squid -k rotate
mv access.log.0 access-\${date}.log
EOF
chmod +x /data/squid-cut.sh
#time
echo '/usr/sbin/ntpdate 210.188.224.10 >& /dev/null' >/data/time.sh
chmod +x /data/time.sh

echo "source /etc/profile" >/data/ip.sh
echo "source /etc/bashrc" >> /data/ip.sh
echo "echo \$(date) \$(ifconfig ppp0 | grep inet |awk '{print \$2}'|awk -F : '{print \$2}') >>/tmp/ip.txt ">>/data/ip.sh

#echo "source /etc/profile" >/data/ip.sh
#echo "source /etc/bashrc" >> /data/ip.sh
#echo "echo \$(date) \$(ifconfig ppp0 | grep inet |awk '{print \$2}') >>/tmp/ip.txt ">>/data/ip.sh

/bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


chmod +x /data/ip.sh
#crontab
echo '0 9 * * * /data/time.sh'  >/var/spool/cron/root
echo '0 0 * * * /data/squid-cut.sh'  >>/var/spool/cron/root
echo '0 1 * * * find /var/log/squid/* -type f -mtime +6 -exec rm {} \; > /dev/null 2>&1'  >>/var/spool/cron/root
echo "0 1 * * * echo ' '> /app/proxy-pool-slave/nohup.out"  >>/var/spool/cron/root
echo "1 1 * * * echo ' ' > /root/telegraf.out "  >>/var/spool/cron/root
echo '*/1 * * * * /data/ip.sh'  >>/var/spool/cron/root

wget -O /data/restartadsl.sh http://dailichi.oss-cn-hangzhou.aliyuncs.com/restartadsl.sh
chmod +x /data/restartadsl.sh
wget http://dailichi.oss-cn-hangzhou.aliyuncs.com/app.tgz && tar zxvf app.tgz -C /

squid -z
# dont forget to source /etc/profile.
# dont forget to source /etc/profile.