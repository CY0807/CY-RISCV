#!/bin/bash

make BIN=$1 1>/dev/null
NAME=`basename -s .bin $1`
NUM=`grep -c TEST_PASS ./build/$NAME.log`

if [ $NUM -eq 0 ]; then
    echo test fall: $1
else
    echo test pass: $1
fi

