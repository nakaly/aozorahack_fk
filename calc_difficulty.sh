#!/bin/bash

while read -r line
do
    url=`echo $line | awk -F ',' '{print $46 }' | sed -e 's/\"//g'`
    curl -LOk $url > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
        continue
    fi
    file_name=`echo $url | awk -F '/' '{print $7}' | sed -e 's/\"//g'`
    new_file_name=`echo $file_name | sed -e 's/zip/txt/g'`
    unzip -c $file_name | nkf -w > $new_file_name
    rm -rf $file_name
    title=`echo $line | awk -F ',' '{print $2 }'`
    first_name=`echo $line | awk -F ',' '{print $16 }'`
    last_name=`echo $line | awk -F ',' '{print $17 }'`
    doc_id=`echo $file_name | awk -F '_' '{print $1 }'`
    echo "$doc_id,$title,$first_name,$last_name"
done < $1
