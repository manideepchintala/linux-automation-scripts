# Linux Automation Scripts

Bash scripts that automate common Linux server operations tasks: health checks, log cleanup, and disk usage alerts. Built from the routine tasks of day-to-day cloud operations work (monitoring, troubleshooting, and housekeeping on AWS EC2 instances).

## Scripts

| Script | What it does |
|---|---|
| `health_check.sh` | Reports hostname, uptime, load average, memory and disk usage, and whether given services are running. Logs to a daily file. |
| `log_cleanup.sh` | Deletes `.log` files older than N days from a directory. Supports `--dry-run` and refuses to run on `/`. |
| `disk_alert.sh` | Prints an alert if any filesystem crosses a usage threshold. Returns exit code 1 so it can be chained with other tools. |
| `crontab.example` | Sample cron entries to schedule all three scripts. |

## Tech used

Bash, Linux (Ubuntu / Amazon Linux), cron, systemd (`systemctl`), Git

## Usage

```bash
git clone https://github.com/YOUR-USERNAME/linux-automation-scripts.git
cd linux-automation-scripts
chmod +x *.sh

# Health check, also checking the ssh and cron services
./health_check.sh ssh cron

# Preview which logs would be deleted, then delete them
./log_cleanup.sh /var/log/myapp 7 --dry-run
./log_cleanup.sh /var/log/myapp 7

# Alert if any disk is 80% or more full
./disk_alert.sh 80
```

## Sample output

```
===== Health Check: 2026-10-24 10:15:02 =====
Hostname : ip-172-31-10-25
Uptime   : up 3 days, 4 hours
Load avg : 0.12 0.08 0.05
Memory   : 412/982 MB used (42.0%)
Disk (/) : 3.1G/8.0G used (39%)
Service  : ssh is RUNNING
Service  : cron is RUNNING
```

*Replace this with the real output from your own run.*

## Scheduling with cron

See `crontab.example`. Run `crontab -e` and paste the entries, changing the paths to match where you cloned the repo.

## What I learned

- Writing safe shell scripts: input validation, dry-run mode, and exit codes
- Reading system data from `/proc`, `free`, `df`, and `systemctl`
- Scheduling recurring jobs with cron
- Using Git and GitHub to version-control scripts

## Author

Manideep Chintala | Cloud Operations Engineer | [LinkedIn](https://www.linkedin.com/public-profile/settings/?trk=d_flagship3_profile_self_view_public_profile&lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_view_base%3BlTvc1q%2FPRoe%2FX4qwNDd73A%3D%3D)
