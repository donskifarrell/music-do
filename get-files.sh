#!/bin/bash 
# A very simple Bash script to download a YouTube video 
# and extract the music file from it. 
counter=1

for filename in *; 
do
	counter=`expr $counter + 1`
	echo COUNT: $counter

		filename
		ext=echo "${filename}"|awk -F . '{print $NF}'
		echo $ext

		ffmpeg -i "${filename}" "${filename}".wav 
		lame "${filename}".wav "${filename}".mp3 
		rm "${filename}" "${filename}".wav 

done
