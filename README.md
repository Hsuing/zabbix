## 1.redis

```
#脚本放入下面目录
/opt/zabbix/script

#导入redis xml模版
```

## 2.TCP

```
#脚本放入下面目录
/opt/zabbix/script

#导入redis xml模版
```

## 3.nginx

```
前提条件：
　　tengine模块安装了http_stub_status_module和upstream_check_module；

　　在nginx的配置文件中配置上：

location /hanstatus {
	access_log off;
	allow 127.0.0.1;
	allow 192.168.136.0/32;
	allow 218.245.64.130;
	deny all;
}
location /tgstatus {
	stub_status on;
	access_log off;
	allow 127.0.0.1;
	allow 192.168.136.0/32;
	deny all;
}
```

```
#脚本放入下面目录
/opt/zabbix/script

#导入nginx xml模版
```



