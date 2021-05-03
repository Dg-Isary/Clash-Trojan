#!/bin/bash
clashlink=clashlink
trojan=trojan
echo > temp
echo > trtmp
wget -qO- $clashlink |grep trojan |awk '{print $2}' > temp
cat temp |while  read line
do
trps=`echo "File:${line}" |awk -F '"password":' 'match($2,/\"([^\"]*)\"/,a){print a[0]}' |awk -F \" '{print $2}'`
trse=`echo "File:${line}" |awk -F '"server":' 'match($2,/\"([^\"]*)\"/,a){print a[0]}' |awk -F \" '{print $2}'`
port=`echo "File:${line}" |awk -F '"port":' '{print $2}' |awk -F ',' '{print $1}'`
trna=`echo "File:${line}" |awk -F '"name":' '{print $2}' |awk -F ',' '{print $1}'`
echo "trojan://$trps@$trse":"$port"#"$trna" >> trtmp
done
cat trtmp|base64 > $trojan
rm temp trtmp
