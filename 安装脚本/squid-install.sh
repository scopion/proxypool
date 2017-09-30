# install squid
squidRepo='/etc/yum.repos.d/squid.repo'

rm -f ${squidRepo}
touch ${squidRepo}

echo '[squid]' >> ${squidRepo}
echo 'name=Squid repo for CentOS Linux - $basearch' >> ${squidRepo}
echo '#IL mirror' >> ${squidRepo}
echo 'baseurl=http://www1.ngtech.co.il/repo/centos/$releasever/$basearch/' >> ${squidRepo}
echo 'failovermethod=priority' >> ${squidRepo}
echo 'enabled=1' >> ${squidRepo}
echo 'gpgcheck=0' >> ${squidRepo}
yum update -y
yum install squid -y