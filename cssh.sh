#!/bin/bash    
echo "csshx-ing into all instances: $1"
type=$2
font="8x16"

aws ec2 describe-instances --region us-east-1  --filters "Name=tag:Name,Values=$1"

if [ "${type}" == "vpc" ]
then
    aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=$1" | grep -A1 'Primary' | grep 'PrivateIpAddress' | cut -f2 -d":" | sed 's/[\",]//g' | xargs cssh -f $font
else
    aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=$1" | grep 'PublicIpAddress' | cut -f2 -d":" | sed 's/[\",]//g' | xargs cssh -f $font
