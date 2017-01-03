# cloudwatch-custom
Use CloudWatch Custom Metric(Disk, Memory Used)

##Make Policy(cloudwatch put access), Role

##EC2 Instance User data(Amazon Linux or installed awscli on linux)
```{r, engine='bash', count_lines}
#!/bin/bash
yum -y update
aws configure set default.region ap-northeast-2
aws configure set default.output json
yum -y install git
git clone https://github.com/leedoing/cloudwatch-custom
chmod +x /cloudwatch-custom/cloudwatchCustom.sh
echo '*/5 * * * * root /cloudwatch-custom/cloudwatchCustom.sh' >> /etc/crontab
/etc/init.d/crond restart
```
https://aws.amazon.com/cli/?nc1=h_ls
