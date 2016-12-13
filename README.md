# cloudwatch-custom
Use CloudWatch Custom Metric(Disk, Memory Used)

##Make Policy(cloudwatch full access), Role

##EC2 Instance User data(Amazon Linux or installed awscli on linux)
```{r, engine='bash', count_lines}
#!/bin/bash
aws configure set default.region ap-northeast-2
yum -y install git
git clone https://github.com/leedoing/cloudwatch-custom
chmod +x /cloudwatch-custom/cloudwatchCustom.sh
echo '*/5 * * * * root /cloudwatch-custom/cloudwatchCustom.sh >> /root/crontab.log' >> /etc/crontab
/etc/init.d/crond start
```
