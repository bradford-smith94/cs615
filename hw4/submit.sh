#!/bin/sh
# Bradford Smith (bsmith8)
# CS 615 hw4 submit.sh
# 03/01/2018
##########################

USER=bsmith8
HW=hw4

tar -cvf ${USER}-${HW}.tar --transform "s/^\./${USER}/" ./*
