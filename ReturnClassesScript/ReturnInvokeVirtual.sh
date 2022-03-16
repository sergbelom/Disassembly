#!/bin/sh

filename=$1
filextension="${filename##*.}"

if [ "$filextension" != "class" ];
then
    echo "Error: incorrect input file"
else
    javap -c $filename | grep invokevirtual | awk '{print $6}' | cut -d':' -f1 | uniq
fi