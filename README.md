# cloudwatch-custom
Use CloudWatch Custom Metric(Disk, Memory Used)

##Make Policy(cloudwatch full access), Role

##EC2 Instance User data
```{r, engine='bash', count_lines}
#!/bin/bash
aws configure set default ap-northeast-2
yum -y install git
git clone https://github.com/leedoing/cloudwatch-custom
chmod +x /root/cloudwatchCustom.sh
echo '*/5 * * * * root /cloudwatch-custom/cloudwatchCustom.sh >> /root/crontab.log' >> /etc/crontab
/etc/init.d/crond start
```
