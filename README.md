# cloudwatch-custom
Use CloudWatch Custom Metric(Disk, Memory Used)

##Make Policy(cloudwatch full access), Role

##EC2 Instance User data
```{r, engine='bash', count_lines}
#!/bin/bash
yum git -y install
git clone https://github.com/leedoing/cloudwatch-custom
chmod +x /root/cloudwatchCustom.sh
echo '*/5 * * * * root /root/cloudwatchCustom.sh >> /root/crontab.log' >> /etc/crontab
/etc/init.d/crond start
```
