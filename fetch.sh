#!/bin/bash
usage="./$0 <input_file> <output_directory>"
if [ "$#" -lt "2" ]
then
	echo $usage
	exit 1
fi
while read url; do
	if [[ -n $url ]]; then
		real_url=$(curl $url -s -L -I -o /dev/null -w '%{url_effective}')
		echo $real_url
		/usr/local/bin/get_flash_videos $real_url -f $2/$(date +"%H%M%S-%m%d%y").flv
		sleep 0.5
	fi
done < $1
