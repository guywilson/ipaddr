#!/bin/bash

git pull

curl -s https://www.ipchicken.com | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" > current_ip.addr

cmp -s ip.addr current_ip.addr

if [ $? -ne 0 ] ; then
    echo Files are different, uploading...
    cp current_ip.addr ip.addr
    rm current_ip.addr
    git commit -m "Updated IP Address"
    git push origin master
fi
