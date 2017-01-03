#!/bin/bash
export AWS_CONFIG_FILE="/root/.aws/config"
#Get EC2-id
instanceid=$(curl http://169.254.169.254/latest/meta-data/instance-id)
 
#Get Memory Used
mem_total=$(free -m |grep Mem |awk '{print $2}')
mem_used=$(free -m |grep Mem |awk '{print $3}')
mem_free=$(free -m |grep Mem |awk '{print $4}')

/usr/bin/aws cloudwatch put-metric-data --metric-name MemTotal --namespace $instanceid --value $mem_total --unit Megabytes
/usr/bin/aws cloudwatch put-metric-data --metric-name MemUsed --namespace $instanceid --value $mem_used --unit Megabytes
/usr/bin/aws cloudwatch put-metric-data --metric-name MemFree --namespace $instanceid --value $mem_free --unit Megabytes
 
#Get Disk Used
disk_num=$(df -h |wc -l)
for((i=2; i<=$disk_num; i++)); do
        disk=$(df -h |sed -n $i'p' |awk '{print $1}')
        used=$(df -h |sed -n $i'p' |awk '{print $5}' |cut -d '%' -f 1)
        /usr/bin/aws cloudwatch put-metric-data --metric-name $disk --namespace $instanceid --value $used --unit Percent
done
