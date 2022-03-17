#!/bin/sh

filename=$1
filextension="${filename##*.}"

if [ "$filextension" != "class" ];
then
    echo "Error: incorrect input file!"
else
    javap -p -c $filename | grep invokevirtual | awk '{print $6}' | cut -d':' -f1 | grep [$.] | cut -d'.' -f1 | sort -u
fi