#!/usr/bin/bash

script=/opt/zabbix/script
scripts=/opt/zabbix/scripts
tmp=/tmp
zabbix=/opt/zabbix

user=`cat /etc/passwd|grep zabbix|wc -l`
host_ip=`ip a|grep inet|grep global|awk '{print $2}'|awk -F'/' '{print $1}'|head -1`
date=`date +"%Y%m%d-%H%M%S"`
cpu=`cat /proc/cpuinfo|grep proc|wc -l`
net=`ifconfig|awk  '{print $1}'|head -1`
#ServerIP=x.x.x.x
ServerIP=x.x.x.x

templates()
{
    if [ $net == 'em1' ]
    then
       network='new'
    else
       network='old'
    fi

    if [ $cpu -le 8 ]
    then
        sed  -i "155a HostMetadata=adrd" /opt/zabbix/conf/zabbix_agentd.conf >/dev/null
    elif [ $cpu -le 16 ]
    then
        sed  -i "155a HostMetadata=adrd" /opt/zabbix/conf/zabbix_agentd.conf >/dev/null
    elif [ $cpu -le 24 ]
    then
        sed  -i "155a HostMetadata=adrd" /opt/zabbix/conf/zabbix_agentd.conf >/dev/null
    elif [ $cpu -le 32 ]
    then
        sed  -i "155a HostMetadata=adrd" /opt/zabbix/conf/zabbix_agentd.conf >/dev/null
		#sed  -i "155a HostMetadata=32 $network sys-extend" /opt/zabbix/conf/zabbix_agentd.conf >/dev/null
    fi
}

install()
{
    rm -rf $zabbix
    tar -zxvf /opt/zabbix-v4.4.5.tar.gz -C /opt >/dev/null
    rm -rf /etc/init.d/zabbix_agentd
	
    sed -i s/Server=IP/Server=${ServerIP}/g /opt/zabbix/conf/zabbix_agentd.conf
    sed -i s/ServerActive=IP/ServerActive=${ServerIP}/g /opt/zabbix/conf/zabbix_agentd.conf
    sed -i s/Hostname=ZabbixServer/Hostname='adrd-'$host_ip/g /opt/zabbix/conf/zabbix_agentd.conf
	
    usermod -G zabbix,wheel zabbix;
    sed -i -e 's/^Defaults.*requiretty/# &/' /etc/sudoers;
    sed -i 's/#.*wheel.*NOPASSWD.*ALL/%wheel        ALL=(ALL)       NOPASSWD: ALL/g' /etc/sudoers;
    templates
    chown -R zabbix:zabbix /opt/zabbix
    if [ -d /tmp/share ]
    then
        cp -r /tmp/share /opt/zabbix/
    fi
    cp $zabbix/log/zabbix_agentd /etc/init.d/zabbix_agentd
    /etc/init.d/zabbix_agentd start
}

if [ -d $zabbix ]
then
    cp -r $zabbix /opt/zabbix-$date.bak
fi

if [ $user -eq 1 ]
then
    echo 'zabbix exists!'
else
    useradd zabbix -s /sbin/nologin
fi

if [ -d /opt/zabbix/share ]
then
    cp -r /opt/zabbix/share/ /tmp/
fi

if [ -d $scripts ]
then 
    cp -r $scripts $tmp
    /etc/init.d/zabbix_agentd stop
    sleep 2
    install
    cp -r $tmp/scripts /opt/zabbix;rm -rf /tmp/scripts
    chown -R root:root /opt/zabbix/scripts
elif [ -d $script ]
then 
    cp -r $script $tmp
    /etc/init.d/zabbix_agentd stop
    sleep 2
    install
    cp -r $tmp/script /opt/zabbix;rm -rf /tmp/script
    chown -R root:root /opt/zabbix/script
else
    if [ `ps -ef |grep zabbix_agentd|grep -v grep|wc -l` -gt 2 ]
    then
        /etc/init.d/zabbix_agentd stop >/dev/null
    fi
    sleep 2
    install
fi

/sbin/chkconfig zabbix_agentd on

