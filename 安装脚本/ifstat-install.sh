#yum install gcc -y
yum groupinstall "Development tools"
wget http://distfiles.macports.org/ifstat/ifstat-1.1.tar.gz
tar xzvf ifstat-1.1.tar.gz
cd ifstat-1.1
./configure
make
make install

echo 'nohup ifstat -atD &' >> start-nohub.sh