#!/bin/bash
# 接口api
api_url="http://127.0.0.1/zabbix/api_jsonrpc.php"
# 编辑json
# 传入json和auth
json=host.getserver.json
token=`bash post_auth.sh && cat token.json`
sed -i 's/"auth":[^,]*/"auth": "'${token}'"/' $json
post_data=`cat ${json}`

# 获取json格式数据
get_date=`curl -s -H "Content-Type: application/json" -X POST  --data "${post_data}" "${api_url}"`
# 获取hostid
hostid=`echo $get_date|sed -n 's/.*"hostid":"\([0-9]*\)".*/\1/p'`
status=`echo $get_date|sed -n 's/.*"status":"\([0-9]*\)".*/\1/p'`


# update new json
jsonserver=host.enable.json
sed -i 's/"hostid":[^,]*/"hostid": "'${hostid}'"/' $jsonserver
sed -i 's/"auth":[^,]*/"auth": "'${token}'"/' $jsonserver
post_data=`cat ${jsonserver}`


# 判断状态是否为0,zabbix中0表示启用
if [ $status != 0 ]
then
   get_date=`curl -s -H "Content-Type: application/json" -X POST  --data "${post_data}" "${api_url}"`
fi
