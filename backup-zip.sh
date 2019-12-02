#!/bin/sh
#By krabelize | cryptsus.com
#httpd htdocs compressed zip and OpenSSL encrypted backup script. Tested on OpenBSD 6.6
#First create an EAS256 key. See blog post for info
#Edit crontab with the following entry. Run this script every night at 05:00
#crontab -e
#0 4 * * * /home/$username/backup-zip.sh

#Variables
source="/var/www/htdocs"
username="username"
dir_name="backup_webdir_cryptsus"
backup_date=$(date +"%d-%m-%Y")
backup_name="/home/$username/$dir_name-$backup_date.zip"
machine="$username@10.0.0.2"
remote_destination="/home/$username/backup-zip"
aes_key="/home/$username/backup.key"
port="22"

zip -r $backup_name $source
if [ $? -eq 0 ]; then
    echo "zip backup file is successfully created"
    openssl enc -in $backup_name -out $backup_name.enc -pass file:$aes_key -e -salt -aes-256-cbc -pbkdf2
    if [ $? -eq 0 ]; then
        echo "encrypted zip backup file is successfully created"
        scp -P $port $backup_name.enc $machine:$remote_destination
        if [ $? -eq 0 ]; then
            echo "[OK - Backup] ssh encrypted zip backup file transfer is successful"
            exit 0
        else
            echo "[FAILED - Backup] ssh encrypted zip transfer failed. Please check your backup script or system settings"
            exit 1
        fi
    else
        echo "encrypted zip backup file failed to created"
        exit 1
    fi
else
    echo "[FAILED - Backup] zip backup file was not created. Please check your backup script or system settings"
    exit 1
fi
