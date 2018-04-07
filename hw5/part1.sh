#!/bin/sh
# Bradford Smith (bsmith8)
# CS 615 HW5 part1.sh
# 04/06/2018
##########################

ANS1=$(gzcat data.gz | grep ^en | wc -l | tr -d '[:space:]')
echo "Answer for q1:" $ANS1

ANS2=$(gzcat data.gz | grep ^en | awk '{print $2, $(NF - 1)}' | sort -nrk 2 | head -n 1 | cut -d ' ' -f 1)
echo "Answer for q2:" $ANS2

ANS3=$(gzcat data.gz | grep ^en | awk '{sum += $NF} END {print sum}')
echo "Answer for q3:" $ANS3

ANS4=$(gzcat data.gz | grep ^en | awk '{sum += $(NF - 1)} END {print sum / 60 / 60 }')
echo "Answer for q4:" $ANS4

ANS5=$(gzcat data.gz | grep ^en | awk '{print $NF / $(NF - 1), $0}' | sort -nr | head -n 1 | cut -d ' ' -f 3)
echo "Answer for q5:" $ANS5

echo "Results:"
./test.sh "$ANS1" "$ANS2" "$ANS3" "$ANS4" "$ANS5"
