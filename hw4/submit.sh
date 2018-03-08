#!/bin/sh
# Bradford Smith (bsmith8)
# CS 615 hw4 submit.sh
# 03/08/2018
##########################

USER=bsmith8
HW=hw4

tar -cvf ${USER}-${HW}.tar --transform "s/^\\./${USER}/" --exclude \
    './traceroutes.tcpdump' --exclude '*.tar' ./*
