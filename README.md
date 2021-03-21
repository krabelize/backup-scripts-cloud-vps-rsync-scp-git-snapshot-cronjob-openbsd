# Backup scripts for Cloud VPSers/VMs with rsync scp git and Snapshots by leveraging cronjobs on OpenBSD
Backup scripts in shell to backup a web directory with rsync, scp, git and snapshots. Tested on OpenBSD 6.6. Read [this article](https://cryptsus.com/blog/how-to-backup-web-directory-on-a-cloud-vps-4-free-and-easy-backup-methods-rsync-scp-zip-github-with-aes256-encryption-and-snapshots.html) for more information.

1) Synchronise the web directory to another directory on a VPS over SSH
2) Copy the compressed web directory in an encryted AES256 zip file to another VPS over SSH
3) Leverage GitHub as a VCS to synchronize the web directory over HTTPS (TLS)
4) Snapshot the VPS by an API over HTTPS (TLS)

You find all three scripts in this repository. We configure these script with the help of crontab:

```bash
crontab -e

0 3 * * * /home/username/backup-rsync.sh
0 4 * * * /home/username/backup-zip.sh
0 5 * * * /home/username/backup-github.sh
0 6 * * * /home/username/backup-vultr-snapshot.sh
```
On the target backup VPS we configure a retention time of 180 days with cron. This way, encrypted backups older than 180 days will be automatically purged/deleted to save disk space:

```bash
crontab -e
0 7 * * * find /home/username/backup-zip -type f -mtime +180 -name "*.zip.enc" -exec rm {} \;
```

# License
Berkeley Software Distribution (BSD)

# Author
[Jeroen van Kessel](https://twitter.com/jeroenvkessel) | [cryptsus.com](https://cryptsus.com) - we craft cyber security solutions
