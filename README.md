# cloudwatch-custom
Use CloudWatch Custom Metric(Disk, Memory Used)

##Make Policy(cloudwatch put access), Role

##EC2 Instance User data(Amazon Linux or installed awscli on linux)
```{r, engine='bash', count_lines}
#!/bin/bash
yum -y update
yum -y install curl
yum -y install git
aws configure set default.region ap-northeast-2
aws configure set default.output json
git clone https://github.com/leedoing/cloudwatch-custom
chmod +x /cloudwatch-custom/cloudwatchCustom.sh
echo '*/5 * * * * root /cloudwatch-custom/cloudwatchCustom.sh' >> /etc/crontab
service crond restart
```
https://aws.amazon.com/cli/?nc1=h_ls
