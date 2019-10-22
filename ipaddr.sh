#!/bin/bash

ACTION='\033[1;90m'
FINISHED='\033[1;96m'
READY='\033[1;92m'
NOCOLOR='\033[0m' # No Color
ERROR='\033[0;31m'

TIMESTAMP=$(date)
FILE=ip.addr

echo
echo -e ${ACTION}Running ipaddr script at ${TIMESTAMP}${NOCOLOR}

# Grab the page from ipchicken.com and find the ip address...
sudo -u guy curl -s https://www.ipchicken.com | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" > current_ip.addr

while IFS= read -r ipaddress; do
    echo -e ${ACTION}Found IP address: $ipaddress${NOCOLOR}
done < "current_ip.addr"

# Check if file exists, create it if not...
if [[ -f "$FILE" ]]; then
    cmp -s ip.addr current_ip.addr

    if [ $? -eq 0 ] ; then
        echo -e ${FINISHED}No change to IP address, exiting${NOCOLOR}
        exit
    fi
else
    sudo -u guy cp current_ip.addr ip.addr
fi

echo -e ${ACTION}Files are different, uploading...${NOCOLOR}
sudo -u guy cp current_ip.addr ip.addr

# Read the FTP credentials from the .credentials file... 
while IFS=: read -r server port ftpusername ftppassword
do
    echo -e ${ACTION}Obtained credentials${NOCOLOR}

    # Call the upload script to push the file to the server...
    ./upload.sh $server $port $ftpusername $ftppassword $FILE
done < ".credentials"

# Cleanup...
rm current_ip.addr
