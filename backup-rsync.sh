#!/bin/sh
#By krabelize | cryptsus.com
#httpd htdocs directory backup script tested on OpenBSD 6.6
#Make sure rsync is installed on both nodes
#Align the 'backup' folder owner with the same ssh-keypair user

#Edit crontab with the following entry
#Run rsync every night at 04:00
#crontab -e
#0 3 * * * * /home/$username/backup-rsync.sh

#Variables
source="/var/www/htdocs/"
username="username"
destination="/home/$username/backup"
machine="$username@10.0.0.2"
port="22"

rsync -av -e "ssh -p $port" $source $machine:$destination
if [ $? -eq 0 ]; then
    logger "[OK - Backup] rsync backup successful"
else
    logger "[FAILED - Backup] rsync backup failed. Please check your backup script or system settings"
fi
