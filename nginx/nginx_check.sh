#!/bin/bash
#auth han

HOST="127.0.0.1"
PORT="10080"
NGINX_STATUS=tgstatus
function ping {
    /sbin/pidof nginx | wc -l 
}
function active {
    /usr/bin/curl "http://$HOST:$PORT/${NGINX_STATUS}/" 2>/dev/null| grep 'Active' | awk '{print $NF}'
}
function reading {
    /usr/bin/curl "http://$HOST:$PORT/${NGINX_STATUS}/" 2>/dev/null| grep 'Reading' | awk '{print $2}'
}
function writing {
    /usr/bin/curl "http://$HOST:$PORT/${NGINX_STATUS}/" 2>/dev/null| grep 'Writing' | awk '{print $4}'
}
function waiting {
    /usr/bin/curl "http://$HOST:$PORT/${NGINX_STATUS}/" 2>/dev/null| grep 'Waiting' | awk '{print $6}'
}
function accepts {
    /usr/bin/curl "http://$HOST:$PORT/${NGINX_STATUS}/" 2>/dev/null| awk NR==3 | awk '{print $1}'
}
function handled {
    /usr/bin/curl "http://$HOST:$PORT/${NGINX_STATUS}/" 2>/dev/null| awk NR==3 | awk '{print $2}'
}
function requests {
    /usr/bin/curl "http://$HOST:$PORT/${NGINX_STATUS}/" 2>/dev/null| awk NR==3 | awk '{print $3}'
}
# 执行function
$1