#!/bin/sh
# Bradford Smith (bsmith8)
# CS 615 HW5 test2.sh
# 04/07/2018
##########################

HOST=http://ec2-54-145-67-75.compute-1.amazonaws.com/
PART2=cgi-bin/hw5-2.cgi

echo curl -H 'Expect:' --data-binary @part2.sh $HOST$PART2
curl -H 'Expect:' --data-binary @part2.sh $HOST$PART2
