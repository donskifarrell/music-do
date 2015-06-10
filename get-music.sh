#!/bin/bash 
# A very simple Bash script to download a YouTube video 
# and extract the music file from it. 
counter=1

while read NAME
do
	counter=`expr $counter + 1`
	echo COUNT: $counter

	address="$NAME" 
	echo Getting: $address
	regex='v=(.*)'
	echo Regex: $regex
	
	
	if [[ $address =~ $regex ]]; then 
		video_id=${BASH_REMATCH[1]}
		echo VideoId-1: $video_id 
		video_id=$(echo $video_id | cut -d'&' -f1) 
		echo VideoId-2: $video_id 
		video_title="$(./youtube-dl --get-title $address)" 
		echo VideoTitle: $video_title 
		
		./youtube-dl $address 
		
		ext="mp4" 
		echo MP4: "$video_title-$video_id.$ext" 
		ffmpeg -i "$video_title-$video_id.$ext" "$video_title".wav 
		lame "$video_title".wav "$video_title".mp3 
		rm "$video_title-$video_id.$ext" "$video_title".wav 
	else 
		echo "Sorry but the system encountered a problem." 
	fi
done < names.txt
