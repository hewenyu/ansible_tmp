### zabbix_server安装(centos7)

```shell
git clone https://github.com/hewenyu/ansible_tmp.git
cd ./ansible_tmp
# 如果有防火墙的话先关掉
ansible zabbixserver -m command -a 'yum remove firewalld -y warn=False'
ansible-playbook zabbix_server.yml
ansible zabbixserver -m raw -a 'zcat /usr/share/doc/zabbix-server-mysql-3.4.8/create.sql.gz |mysql -uroot zabbix'

# 数据库默认  user=zabbix password=zabbix DBname=zabbix
```
然后可以打开http://{host}/zabbix


```shell
# 在通过web 安装完成后,面板出现后,启用server 的agent的数据收集
ansible zabbixserver -u root -m shell -a 'bash post.sh  chdir=/root/test/'
```
如果zabbix要使用用中文
* 选项设置修改成中文
* 将字体文 simkai.ttf件放入 /usr/share/zabbix/fonts/
* 把zabbix的配置文件字体替换成这个simkai.ttf(配置文件路径/usr/share/zabbix/include/defines.inc.php)

```shell
define('ZBX_FONTPATH',           realpath('fonts')); // where to search for font (GD > 2.0.18)
define('ZBX_GRAPH_FONT_NAME',  'simkai'); // font file name
```

### zabbix_agent安装(centos7)
```shell
git clone https://github.com/hewenyu/ansible_tmp.git
cd ./ansible_tmp
# 如果有防火墙的话先关掉
ansible zabbixagent -m command -a 'yum remove firewalld -y warn=False'
# 这个需要安装一个zabbix的模块 pip install zabbix-api
# 而且host需要预先配置好一些环境变量 例子如下
#######################################################
# tmp_host
[zabbixserver]
zabbix_server ansible_ssh_host=192.168.1.20
[zabbixagent]
web ansible_ssh_host=192.168.2.20
[zabbix:children]
zabbixserver
zabbixagent
[zabbix:vars]
server_ip=192.168.1.20
server_url=http://192.168.1.20/zabbix/
login_user=Admin
login_password=zabbix
#######################################################

ansible-playbook zabbix_agent.yml
```


### lnmp 安装 (centos7 php 7.2) 

```shell
git clone https://github.com/hewenyu/ansible_tmp.git
cd ./ansible_tmp
# 如果有防火墙的话先关掉
ansible node -m command -a 'yum remove firewalld -y warn=False'
ansible-playbook lnmp.yml
```
然后可以打开http://{host}/info.php