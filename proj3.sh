#!/bin/bash

printHeader()
{
	echo "$(date)"
	printf %"$COLUMNS"s | tr " " "-"
	echo " Main Menu"
	printf %"$COLUMNS"s | tr " " "-"
}

printf %"$COLUMNS"s | tr " " "-"
printHeader
PS3="Please enter your choice [1-10] "

options=("Operating system info"
	 "Hostname and DNS info"
	 "Network info"
	 "Who is online"
	 "Last logged in users"
	 "My IP address"
	 "My disk usage"
	 "My home file-tree"
	 "Process operations"
	 "Exit")

select opt in "${options[@]}" 
do
	case $opt in
		"Operating system info")
			printf %"$COLUMNS"s | tr " " "-"
			echo " System information"
			printf %"$COLUMNS"s | tr " " "-"
			echo "$(hostnamectl | grep "Operating System:" | awk '{gsub(/^ +| +$/,"")} {print $0}')"
			echo "$(lsb_release -a)"
			read -p "Press [Enter] key to continue..."
			printHeader		
			;;
		"Hostname and DNS info")
			printf %"$COLUMNS"s | tr " " "-"
			echo " Hostname and DNS information"
			printf %"$COLUMNS"s | tr " " "-"
			echo "Hostname : $(hostname)"
			echo "DNS domain : $(hostname -d)"
			echo "Fully qualified domain name : $(hostname -f)"
			echo "Network address (IP) : $(hostname -i | awk '{ print $2 }')"
			echo "DNS name servers (DNS IP) : $(grep "nameserver" /etc/resolv.conf | awk '{ print $2 }')" 
			read -p "Press [Enter] key to continue..."
			printHeader
			;;
		"Network info")
			printf %"$COLUMNS"s | tr " " "-"
			echo 
			echo -n " Network Information"
			printf %"$COLUMNS"s | tr " " "-"
			echo 
			echo -n "Total network interfaes found: $(ls -A /sys/class/net | wc -l)"
			echo "$(ip a)"
			echo "***********************"
			echo "*** Network Routing ***"
			echo "***********************"
			echo "$(netstat -rn)"
			echo "*************************************"
			echo "*** Interface Traffic Information ***"
			echo "*************************************"
			echo "$(netstat -i)"
			read -p "Press [Enter] key to continue..."
			printHeader
			;;
		"Who is online")
			printf %"$COLUMNS"s | tr " " "-"
			echo " Who is online"
			printf %"$COLUMNS"s | tr " " "-"
			echo "$(who -Hs)"
			read -p "Press [Enter] key to continue..."
			printHeader
			;;
		"Last logged in users")
			printf %"$COLUMNS"s | tr " " "-"
			echo " Last Logged in Users"
			printf %"$COLUMNS"s | tr " " "-"
			echo "$(lastlog | grep -v  **Never)"
			read -p "Press [Enter] key to continue..."
			printHeader
			;;
		"My IP address")
			printf %"$COLUMNS"s | tr " " "-"
			echo " Public IP Information"
			printf %"$COLUMNS"s | tr " " "-"
			# echo "$(host myip.opendns.com resolver1.opendns.com | grep "myip.opendns.com has" | awk '{print $4}')"
			echo "$(dig +short myip.opendns.com @resolver1.opendns.com)"
			read -p "Press [Enter] key to continue..."
			printHeader
			;;
		"My disk usage")
			printf %"$COLUMNS"s | tr " " "-"
			echo " Disk Usage information"
			printf %"$COLUMNS"s | tr " " "-"
			echo "$(df | awk '{printf("%3s %s\n", $5, $6);}')"
			read -p "Press [Enter] key to continue..."
			printHeader
			;;
		"My home file-tree")
			sh ./search.sh
			read -p "Press [Enter] key to continue..."
			printHeader
			;;
		"Process operations")
			sh ./proc.sh
			break
			;;
		"Exit")
			break
			;;
		*)
			echo "Invalid option, please try again."
			;;
		
	esac
done

