# cloudwatch-custom
Use CloudWatch Custom Metric(Disk, Memory Used)

##Make Policy(cloudwatch put access), Role

##EC2 Instance User data(Amazon Linux or installed awscli on linux)
```{r, engine='bash', count_lines}
#!/bin/bash
yum -y update
yum -y install curl
yum -y install git
pip install --upgrade pip
pip install awscli
aws configure set default.region ap-northeast-2
aws configure set default.output json
git clone https://github.com/leedoing/cloudwatch-custom
chmod +x /cloudwatch-custom/cloudwatchCustom.sh
echo '*/5 * * * * root /cloudwatch-custom/cloudwatchCustom.sh' >> /etc/crontab
service crond restart
```
https://aws.amazon.com/cli/?nc1=h_ls


##Addition CloudFront Monitoring
```{r,engine='bash', count_lines}
#!/bin/bash
 
##CF ISSUE CHECK
#CURL, MUUT PACKEGE INSTALL
echo "Packages Install(curl, mutt)"
mutt=$(cat /etc/issue)
os=`echo $mutt | cut -f1 -d" "`
if [ "$os" = "Amazon" -o "$os" = "CentOS" -o "$os" = "Red" ]
then
        mutt=$(yum -y install mutt)
        echo "$mutt"
        curl=$(yum -y install curl-devel)
        echo "$curl"
else
        mutt=$(apt-get install mutt)
        echo "$mutt"
        curl=$(apt-get install curl)
        echo "$curl"
fi
echo "Packages install completed(curl, mutt)"
 
#HOST NAME
host_name=$(hostname)
dns_resolv=$(cat /etc/resolv.conf)
mutt=$(yum -y install mutt)
curl=$(yum -y install curl-devel)
 
echo -n "Input URL(ex. https://media.amazonwebservices.com/urchin.js): "
read URL
echo -n "Input mail Address(ex. user@hostname.com): "
read MAIL
 
pwd=$(pwd)
path=$pwd/cf_issue_$host_name.log
echo Save $path
HOST=`echo $URL | cut -f3 -d"/"`
 
#Host Infomation
exec 3<> cf_issue_$host_name.log
echo "Host_name: " $host_name >&3
echo "DNS_resolv" >&3
echo "$dns_resolv" >&3
echo >&3
 
##1.DNS RESOLVER
echo "[1. DNS RESOLVER]" >&3
dns_query=$(dig resolver-identity.cloudfront.net +trace)
echo "$dns_query" >&3
echo >&3
 
##2. CURL SPEED
#curl_speed=$(curl -w "%{time_namelookup}/%{time_connect}/%{time_starttransfer}/%{time_total}" -tlsv1.2 -o /dev/null -s "https://images-na.ssl-images-amazon.com/images/G/01/awssignin/static/aws_logo_smile.png")
curl_speed=$(curl -w "%{time_namelookup}/%{time_connect}/%{time_starttransfer}/%{time_total}" -tlsv1.2 -o /dev/null -s "$URL")
        time_namelookup=`echo $curl_speed | cut -f1 -d"/"`
        time_connect=`echo $curl_speed | cut -f2 -d"/"`
        time_starttransfer=`echo $curl_speed | cut -f3 -d"/"`
        time_total=`echo $curl_speed | cut -f4 -d"/"`
        time_connect_r=`echo "$time_connect - $time_namelookup"|bc`
        time_starttransfer_r=`echo "$time_starttransfer - $time_connect"|bc`
echo "[2. CURL SPEED]" >&3
echo $(date) time_namelookup=$time_namelookup time_connect=$time_connect_r time_starttransfer=$time_starttransfer_r time_total=$time_total >&3
echo >&3
 
##3. CURL RESPONSE HEADER
#curl_header=$(curl -v -tlsv1.2 -o /dev/null -s "https://images-na.ssl-images-amazon.com/images/G/01/awssignin/static/aws_logo_smile.png")
curl_header=$(curl -I -tlsv1.2 -s "$URL")
echo "[3. CF RESPONSE HEADER]" >&3
echo "$curl_header" >&3
echo >&3
 
##4. NETWORK TRACE
echo "[4. NETWORK TRACEROUTE]" >&3
network_trace=$(traceroute -T "$HOST")
echo "$network_trace" >&3
echo >&3
 
#Send mail
mutt -s "CloudFront Issue Check_$host_name" $MAIL < $path
```
