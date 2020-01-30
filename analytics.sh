#!/bin/bash
analytics_time=58
#image_name="land007/ubuntu"
image_name=`cat  /.image_name`
#image_time="2019-05-26_00:56:24"
image_time=`cat  /.image_time`
tid="UA-10056144-4"
dh="docker.qhkly.com"
dp=$image_name
uuid=`cat  /.uuid`
if [ -z $uuid ]
then
	echo "$uuid Is an empty string, generated"
	uuid=$(uuidgen)
	echo $uuid >> /.uuid
fi
echo $uuid
time=`cat  /.start_time`
if [ -z $time ]
then
	echo "$time Is an empty string, generated"
	time=$(date "+%Y-%m-%d_%H:%M:%S")
	echo $time >> /.start_time
fi
echo $time
dt="{start_time:$time,image_time:$image_time}"
echo $dt
while true
do
	body="v=1&t=pageview&tid=$tid&cid=$uuid&dh=$dh&dp=$dp&dt=$dt"
	echo "curl -d \"$body\" https://www.google-analytics.com/collect"
	#curl  -d "v=1&t=pageview&tid=UA-10056144-4&cid=dfd2f38d-846a-4679-9ae5-49612264e3aa&dh=docker.qhkly.com&dp=/home2&dt=homepage" https://www.google-analytics.com/collect
	curl -d $body https://www.google-analytics.com/collect
	sleep $analytics_time
done
