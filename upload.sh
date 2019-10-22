#!/bin/bash

##################################################################################
#                                                                                #
# Script to upload a file to an FTP server                                       #
#                                                                                #
# Parameters:                                                                    #
#     server                                                                     #
#     port                                                                       #
#     username                                                                   #
#     password                                                                   #
#     filename                                                                   #
##################################################################################

SERVER=$1
PORT=$2
USERNAME=$3
PASSWORD=$4
FILE=$5

REMOTEDIR=htdocs/ip

# Perform the FTP upload...
ftp -n $SERVER $PORT << EOF
quote USER $USERNAME
quote PASS $PASSWORD
cd $REMOTEDIR
put $FILE
quit
EOF
