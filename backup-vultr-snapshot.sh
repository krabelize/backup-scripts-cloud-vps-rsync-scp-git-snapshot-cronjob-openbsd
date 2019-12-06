#!/bin/sh
#By krabelize | cryptsus.com
#Create automatic snapshots on vultr.com and delete older snapshots. Tested on OpenBSD 6.6
#Go to https://my.vultr.com/settings/#settingsapi to get your API key
#Only allow the Vultr API to be accessed from your bastion /32 Vultr instance(s)
#Install jquery on your bastion VPS (pkg_add jq)
#Add this script to your crontab under a non-root account
#Edit crontab with the following entry. Run this script every night at 06:00
#crontab -e
#0 6 * * * /home/username/backup-vultr-snapshot.sh

#Variables
#Put your API key here
api_key="API_KEY_HERE"
#Vultr API
API="https://api.vultr.com/v1"
#We keep the total number of snapshots under 11 based on two virtual private servers (VPS)
snapshot_limit="8"

#Query all VPS SUBIDs
VPS_names=$(curl -s "$API/server/list?api_key=$api_key" | jq -r 'keys | '.[]'')
#Query all snapshots and count them
snapshot_count=$(curl -s "$API/snapshot/list?api_key=$api_key" | jq -r 'keys | .[]' | wc -l | awk '{ print $1 }')
#Query last snapshot ID
last_snapshot_ID=$(curl -s "$API/snapshot/list?api_key=$api_key" | jq -r 'keys_unsorted | .[]' | tail -1)

#Delete the oldest snapshots until the $snapshot_limit is reached
if [ "$snapshot_count" -gt "$snapshot_limit" ]; then
    curl -s "$API/snapshot/destroy?api_key=$api_key" --data SNAPSHOTID=$last_snapshot_ID
    if [ "$?" -eq "0" ]; then
        logger "[Vultr.com] Deleted Snapshot ID: '$last_snapshot_ID'"
            break
    else
        logger "[Vultr.com] Failed to delete snapshot ID: '$last_snapshot_ID'"
        exit 1
    fi
fi

#Creating a snapshot for every existing VPS
for vps in $VPS_names; do
    VPS_label=$(curl -s "$API/server/list?api_key=$api_key&SUBID=$vps" | jq -r '.label')
    if curl -s "$API/snapshot/create?api_key=$api_key" --data SUBID=$vps --data description=$VPS_label | grep -q 'SNAPSHOTID'; then
        logger "[OK - Backup] Creating a snapshot for VPS on Vultr: '$VPS_label' with SUBID: '$vps'"
    else
        logger "[FAILED - Backup] Failed to create snapshot for VPS on Vultr: '$VPS_label' with SUBID: '$vps'"
    fi
done
