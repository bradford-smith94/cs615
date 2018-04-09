#!/bin/sh
# Bradford Smith (bsmith8)
# CS 615 hw5 submit.sh
# 04/08/2018
##########################

USER=bsmith8
HW=hw5

tar -cvf ${USER}-${HW}.tar --transform "s/^\\./${USER}/" \
    --transform "s/HW5-${USER}/README/" \
    --transform "s/part3.sh/wikistats/" ./HW5-${USER} ./part3.sh
