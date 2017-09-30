#docker build -t yujieshui/squid .
#docker run -itd --name squid -p 8888:8888 yujieshui/squid
#docker exec squid service squid start
#Ctrl+P+Q

FROM redis:3.0.1

MAINTAINER yujieshui a1178615156@gmail.com

ADD redis-7000.conf redis-7000.conf
ADD redis-7001.conf redis-7001.conf
ADD redis-7002.conf redis-7002.conf
ADD redis-7003.conf redis-7003.conf
ADD redis-7004.conf redis-7004.conf
ADD redis-7005.conf redis-7005.conf

RUN  rm -f redis-ckuster-start.sh 
 &&  touch redis-ckuster-start.sh 
 &&  echo './redis-server redis-7000.conf &	 ' >> redis-ckuster-start.sh 
 &&  echo './redis-server redis-7001.conf &	 ' >> redis-ckuster-start.sh 
 &&  echo './redis-server redis-7002.conf &	 ' >> redis-ckuster-start.sh 
 &&  echo './redis-server redis-7003.conf &  ' >> redis-ckuster-start.sh 
 &&  echo './redis-server redis-7004.conf &  ' >> redis-ckuster-start.sh 
 &&  echo './redis-server redis-7005.conf &  ' >> redis-ckuster-start.sh 
 &&  echo './redis-trib.rb create --replicas 1 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005' >> redis-ckuster-start.sh 




EXPOSE 7000/tcp 7001/tcp 7002/tcp 7003/tcp 7004/tcp 7005/tcp
