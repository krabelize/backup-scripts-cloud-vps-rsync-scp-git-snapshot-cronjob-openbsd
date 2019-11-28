#!/bin/sh
#By krabelize | cryptsus.com
#Create automatic backup to GitHub for the httpd directory
#Check your GitHub repo security settings. Select a public or private repo
#Generate a unique GitHub personal access tokens which is used as your password
#Perform a git clone in /var/www/ the first time after creating the repo on github.com
#chown -R $username:$username .git/ to execute the git command without root user

#Edit crontab with the following entry
#Run this script every night at 06:00
#crontab -e
#0 5 * * * /home/$username/backup-github.sh

#Variables
source="/var/www/htdocs"
username="username"
github_token="github_token_here"
credentials="$username:$github_token"
destination="github.com/$username/htdocs.git"
backupdate=$(date +"%d-%m-%Y")

cd $source
git config --global user.name $username
git init $source
if [ $? -eq 0 ]; then
        git add -u
        git add *
        git commit --author="$username system cronjob sync <>" -m $backupdate
        git push -f https://$credentials@$destination master
        if [ $? -eq 0 ]; then
                logger "[OK - Backup] GitHub backup successful"
                exit 0
        else
                logger "[FAILED - Backup] GitHub backup script failed. Please check your backup script or system settings"
                exit 1
        fi
else
    logger "[FAILED - Backup] GitHub backup script failed. Please check your backup script or system settings"
        exit 1
fi
