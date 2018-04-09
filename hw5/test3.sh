#!/bin/sh
# Bradford Smith (bsmith8)
# CS 615 HW5 test3.sh
# 04/08/2018
##########################

HOST=http://ec2-54-145-67-75.compute-1.amazonaws.com/
PART3=cgi-bin/hw5-3.cgi

echo curl -H 'Expect:' --data-binary @part3.sh $HOST$PART3
curl -H 'Expect:' --data-binary @part3.sh $HOST$PART3
