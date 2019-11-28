#!/bin/sh
#By krabelize | cryptsus.com
#httpd htdocs compressed zip directory backup script tested on OpenBSD 6.6

#Edit crontab with the following entry
#Run this script every night at 05:00
#crontab -e
#0 4 * * * /home/$username/backup-zip.sh

#Variables
source="/var/www/htdocs"
username="username"
backup_name="backup_webdir_webname"
machine="$username@10.0.0.2"
destination="/home/$username/backup-zip"
backup_date=$(date +"%d-%m-%Y")
port="22"

zip -r /home/"$username"/"$backup_name"-"$backup_date".zip $source
if [ $? -eq 0 ]; then
    logger "zip backup is successfully created"
        scp -P $port /home/"$username"/"$backup_name"-"$backup_date".zip $machine:$destination
        if [ $? -eq 0 ]; then
                logger "[OK - Backup] ssh backup transfer is successful"
                else
                logger "[FAILED - Backup] ssh backup transfer failed. Please check your backup script or system settings"
        fi
else
    logger "[FAILED - Backup] zip backup file was not created. Please check your backup script or system settings"
fi
