#! /bin/bash

mail_list_day="qinb.net"
#mail_list_rate="pla.net"
#mail_list_day="liuzho.net,qinh.net"
#mail_list_rate="liuzh.net"
#mail_list="zhao.net,xia.net,che.net,hu.net"

fund_day()
{
        python /root/ipcount.py  > /tmp/fund_mail
        if [ $? -ne 13 ]
        then
                mutt -s "公积金授权结果统计" $mail_list_day < /tmp/fund_mail
                echo "邮件发送成功."
        fi  
}

fund_rate()
{
        echo "公积金成功率预警" > /tmp/fundrate_mail
        python /data/shell/fund.py fund_rate >> /tmp/fundrate_mail
        num_w=`cat /tmp/fundrate_mail |wc -l`
        if [ $? -ne 14 -a $num_w != 2 ] 
        then
                mutt -s "公积金成功率预警" $mail_list_rate < /tmp/fundrate_mail
                echo "邮件发送成功."
        fi  
}


case $1 in
	fund_day)
			fund_day     ;;
	fund_rate)
			fund_rate    ;;
	*)
			echo "You have a problem with the options you have entered."  ;;
esac
