#!/bin/sh

. ./funcs.sh

while [ 1 ]; do
    ./fetch.sh
    gitupload .
    #sleep 300
done
