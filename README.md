# backup Scripts for Cloud VPS-ers with rsync scp git and Snapshot by leveraging cronjobs on OpenBSD
Backup scripts in shell to backup a web directory with rsync, scp, git and snapshots. Tested on OpenBSD 6.6

1) rsync to a different machine
2) compressed zip of the whole directory to a different directory and to a different machine
3) GitHub sync which obviously includes version control (VCS)
4) Vultr daily snapshots of the complete VPS 

You find all three scripts in this repository. We configure these script with the help of crontab:

```bash
cronjob -e<br>

0 3 * * * /home/krabelize/backup-rsync.sh
0 4 * * * /home/krabelize/backup-zip.sh
0 5 * * * /home/krabelize/backup-github.sh
0 6 * * * /home/krabelize/backup-vultr-snapshot.sh
```
  
# License
Berkeley Software Distribution (BSD)

# Author
[Jeroen van Kessel](https://twitter.com/jeroenvkessel) | [cryptsus.com](https://cryptsus.com) - we craft cyber security solutions
