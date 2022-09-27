## 1.redis

> 注意脚本有可执行权限
>
> 此环境在zabbix4.4.5下

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

server {
    listen 10080 ;
    server_name  127.0.0.1;

    location /tgstatus {
	    stub_status on;
            access_log  off;
            allow 127.0.0.1;
            deny all;
   }
    location /hanstatus {
            check_status;
            access_log   off;
            allow 127.0.0.1;
            deny all;
        }
}

```

```
#脚本放入下面目录
/opt/zabbix/script

#导入nginx xml模版
```



