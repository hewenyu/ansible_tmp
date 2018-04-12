#!/bin/bash

#数据库Server信息
HOSTNAME="127.0.0.1"
PORT="3306"
USERNAME="root"
# 刚刚创建好的数据库是没有密码的，mysql 5.6
# PASSWORD="youpassword"

#要创建的数据库的库名称
DBNAME=zabbix
DBUSER=zabbix
DBPWD=zabbix


# 有帐号密码的可以试用这个
# MYSQL_CMD="mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD}"
MYSQL_CMD="mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME}"
echo ${MYSQL_CMD}

# 删除数据库
echo "drop database ${DBNAME}"
create_db_sql="drop database IF EXISTS ${DBNAME}"
echo ${create_db_sql}  | ${MYSQL_CMD} 
if [ $? -ne 0 ]
then  
 echo "drop databases ${DBNAME} failed ..."  
 exit 1  
fi

# 创建数据库
echo "create database ${DBNAME}"  
create_db_sql="create database IF NOT EXISTS ${DBNAME} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci" 
echo ${create_db_sql}  | ${MYSQL_CMD}
if [ $? -ne 0 ] 
then  
 echo "create databases ${DBNAME} failed ..."  
 exit 1  
fi 


# 赋予数据库权限
echo "create database ${DBUSER} password ${DBPWD}"
create_db_sql="GRANT ALL ON ${DBNAME}.* TO '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPWD}'"
echo ${create_db_sql} | ${MYSQL_CMD}
if [ $? -ne 0 ]
then
 echo "GRANT databases ${DBNAME} failed ..."
 exit 1
fi

# 生成文件以便给ansible 确认不会再度执行
touch ready.hi