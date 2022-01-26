#!/bin/sh


key=`find MECHANICAL`
IFS='
'

for fname in $key
do
# echo $key | while read fname; do
    echo $fname
    echo
done