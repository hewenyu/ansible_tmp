#!/bin/bash
# 接口api
api_url="http://127.0.0.1/zabbix/api_jsonrpc.php"
# 编辑json
post_data=`cat login.json`
get_date=`curl -s -H "Content-Type: application/json" -X POST  --data "${post_data}" "${api_url}"`
echo $get_date |awk -F '"' '{print $(8)}' > token.json
