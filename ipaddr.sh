#!/bin/bash

ACTION='\033[1;90m'
FINISHED='\033[1;96m'
READY='\033[1;92m'
NOCOLOR='\033[0m' # No Color
ERROR='\033[0;31m'

TIMESTAMP=$(date)

echo
echo -e ${ACTION}Running ipaddr script at ${TIMESTAMP}${NOCOLOR}

while IFS= read -r credentials; do
    echo -e ${ACTION}Obtained credentials${NOCOLOR}
done < ".credentials"

curl -s https://www.ipchicken.com | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" > current_ip.addr

while IFS= read -r ipaddress; do
    echo -e ${ACTION}Found IP address: $ipaddress${NOCOLOR}
done < "current_ip.addr"

cmp -s ip.addr current_ip.addr

if [ $? -ne 0 ] ; then
    echo -e ${ACTION}Files are different, uploading...${NOCOLOR}
    cp current_ip.addr ip.addr
    git add ip.addr
    git commit -m "Updated IP Address"
    git push https://$credentials@github.com/guywilson/ipaddr.git
fi

rm current_ip.addr
