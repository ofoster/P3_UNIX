#!/bin/bash

printOptions()
{
	for i in 1 2 3 4
	do 
		echo "$i) ${options[$i-1]}"
	done
}

quit()
{
	read value
	if [[ "$value" == ":q" ]] 
	then
		break
		printOptions
	else
		quit
	fi
	
}

PS3="Please enter your choice [1-4] "

options=("Show all processes"
	 "Kill a process"
	 "Bring up top"
	 "Return to Main Menu")

select opt in "${options[@]}" 
do
	case $opt in
		"Show all processes")
			ps -ef
			quit
			;;
		"Kill a process")
			read -p "Please enter the PID of the process you would like to kill: " pid
			# Check if PID exists
			if ps -p $pid > /dev/null
			then 
				kill -9 $pid
			fi
			quit
			;;
		"Bring up top")
			top
			quit
			;;
		"Return to Main Menu")
			sh ./proj3.sh
			break
			;;
		*)
			echo "Invalid option, please try again."
			;;
	esac
done
