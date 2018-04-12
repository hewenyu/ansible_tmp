### zabbix_server安装(centos7)

```shell
git clone git@github.com:hewenyu/ansible_tmp.git
cd ansible
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

