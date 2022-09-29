#!/usr/local/python2.7/bin/python
# -*- coding: UTF-8 -*-
#auth han

import requests
import json
import sys

def get_content():
    url = "http://127.0.0.1:10080/hanstatus?format=json"
    res =  requests.get(url,timeout=5)
    content = res.text
    return json.loads(content)

def get_discovery():
    content = get_content()
    res={"data":[]}
    for i in content['servers']['server']:
        res["data"].append({"{#SNAME}":(i['upstream']+'-'+i['name']).encode('utf8')})
    print(json.dumps(res))
    return res

def _get_attr(content,text,upstream):
    for i in content['servers']['server']:
        if upstream == i['upstream']+'-'+i['name']:
            print(i[text])
            return i[text]
    return None
    


if __name__ == '__main__':
    func = sys.argv[1]
    upstream = sys.argv[3]
    text=sys.argv[2]
    if func == 'nginx.discovery':
        get_discovery()
    else:
        content=get_content()
        _get_attr(content,text,upstream)