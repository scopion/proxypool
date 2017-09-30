adsl-stop
sleep 2
adsl-start
for i in 1 2 3;do
echo 5555555
if ! ping -c 4 www.baidu.com 2>/dev/null |grep "ttl=[0-9]\+"
then
adsl-stop
sleep 3
echo asdasdas
adsl-start
fi
done
