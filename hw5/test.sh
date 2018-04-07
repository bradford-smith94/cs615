#!/bin/sh
# Bradford Smith (bsmith8)
# CS 615 HW5 test.sh
# 04/06/2018
##########################

HOST=http://ec2-54-145-67-75.compute-1.amazonaws.com/
PART1=cgi-bin/hw5-1.cgi
ANSWERS="?q1=$1&q2=$2&q3=$3&q4=$4&q5=$5"

echo $HOST$PART1$ANSWERS
curl $HOST$PART1$ANSWERS
