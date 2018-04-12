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

如果zabbix要使用用中文
* 选项设置修改成中文
* 将字体文 simkai.ttf件放入 /usr/share/zabbix/fonts/
* 把zabbix的配置文件字体替换成这个simkai.ttf(配置文件路径/usr/share/zabbix/include/defines.inc.php)

```shell
define('ZBX_FONTPATH',                          realpath('fonts')); // where to search for font (GD > 2.0.18)
define('ZBX_GRAPH_FONT_NAME',           'simkai'); // font file name
```

### lnmp 安装 (centos7 php 7.2) 

```shell
git clone https://github.com/hewenyu/ansible_tmp.git
cd ./ansible_tmp/nginx-php
# 如果有防火墙的话先关掉
ansible node -m command -a 'yum remove firewalld -y warn=False'
ansible-playbook lnmp.yml
```
