#!/bin/bash
usage="./$0 <video_directory>"
if [ "$#" -lt "1" ]
then
	echo $usage
	exit 1
fi
flvs=($(ls ${1%/}/*.flv))
for flv in "${flvs[@]}"
do
	bn=$(basename -s .flv $flv)
	mp4="$bn.mp4"
	echo "Converting $flv..."
	ffmpeg -i $flv -c:a copy -sameq ${1%/}/$mp4
done
