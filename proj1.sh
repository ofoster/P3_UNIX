#!/bin/bash
#Search script revised for Project 3

root=~
output_file="$(pwd)/filetree.html"

echo "<!DOCTYPE html>">>$output_file
echo "<html>">>$output_file
echo "<body>">>$output_file
counter=0
parent=$(basename $root)
dirlist=$(find $root -type d)
for dir in $dirlist
	do
	#echo $dir
	dir_name=$(basename $dir)
	#echo $dir_name
	if [[ "$dir" == *"$parent"* ]]
		then
		((counter++))
		parent=$dir_name
		else
		counter=3
		parent=$(basename $root)
		fi
	for i in $(seq 2 $counter)
		do
		echo "<ul>" >>$output_file
		done
	if [[ -r $dir ]]
		then
		echo "<li>"$dir_name"</li>" >>$output_file
		fi
	echo "<ul>" >>$output_file
	filelist=$(find $dir -mindepth 1 -maxdepth 1 -type f)
	cd $dir
	for file in $filelist
       		do
       		filename=$(basename $file)
       		if [[ -r $file ]]
       			then
			echo "<li><a href=""$file"">"$filename"</a></li>" >>$output_file
			else
			echo "<li>"$filename"</li>" >>$output_file
			fi
		done
	for i in $(seq 1 $counter)
		do
		echo "</ul>" >>$output_file
		done
done	

echo "</html>">>$output_file
echo "</body>">>$output_file


