#!/bin/bash
usage="./$0 <input_file> <output_directory>"
get_flash_videos="/usr/local/bin/get_flash_videos"
if [ "$#" -lt "2" ]
then
	echo $usage
	exit 1
fi
while read url; do
	if [[ -n $url ]]; then
		real_url=$(curl $url -s -L -I -o /dev/null -w '%{url_effective}')
		echo $real_url
		filename=$($get_flash_videos -info $real_url | grep 'Filename:' \
			| awk '{ print $2 }')
		ext=${filename##*.}
		if [ "$ext" == "mp4" ]; then
			$get_flash_videos $real_url -f ${2%/}/$filename
		else
			$get_flash_videos $real_url -f ${2%/}/$(date +"%H%M%S-%m%d%y").flv
		fi
		sleep 0.5
	fi
done < $1
