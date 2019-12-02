# Backup Scripts for Cloud VPS-ers with rsync scp git and Snapshot by leveraging cronjobs on OpenBSD
Backup scripts in shell to backup a web directory with rsync, scp, git and snapshots. Tested on OpenBSD 6.6

1) rsync to a different machine
2) compressed zip of the whole directory to a different directory and to a different machine
3) GitHub sync which obviously includes version control (VCS)
4) Vultr daily snapshots of the complete VPS 

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
