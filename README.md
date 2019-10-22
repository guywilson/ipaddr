# ipaddr
Get the external IP address from a linux machine on your network. Typically run as a cron job.

Uses upload.sh to upload the changed ip address file to an ftp server, credentials of the ftp server are held in a file called .credentials, with the following format:

ftp_server:ftp_port:ftp_username:ftp_password

Tip: Create the .credentials file from the root account with read/write from root only
