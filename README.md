# Backup scripts for Cloud VPSers/VMs with rsync scp git and Snapshots by leveraging cronjobs on OpenBSD
Backup scripts in shell to backup a web directory with rsync, scp, git and snapshots. Tested on OpenBSD 6.6. Read [this article](https://cryptsus.com/blog/xxxxxxxxxxxxxx.html) for more information.

1) Synchronise the web directory to another directory on a VPS over SSH
2) Copy the compressed web directory in an encryted AES256 zip file to another VPS over SSH
3) Leverage GitHub as a VCS to synchronize the web directory over HTTPS (TLS)
4) Snapshot the VPS by an API over HTTPS (TLS)

You find all three scripts in this repository. We configure these script with the help of crontab:

```bash
cronjob -e

0 3 * * * /home/username/backup-rsync.sh
0 4 * * * /home/username/backup-zip.sh
0 5 * * * /home/username/backup-github.sh
0 6 * * * /home/username/backup-vultr-snapshot.sh
```
  
# License
Berkeley Software Distribution (BSD)

# Author
[Jeroen van Kessel](https://twitter.com/jeroenvkessel) | [cryptsus.com](https://cryptsus.com) - we craft cyber security solutions
