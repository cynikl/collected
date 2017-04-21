#!/bin/sh
##BETA Script to change Owner of AD users
##This script requires the Fileset 'Change DesktopOwner by login' to be first deployed


##Read the user name of the logged in user from /usr/local/etc/fwcld.conf
mv -f /usr/local/etc/fwcld.conf /usr/local/etc/fwcld.conf.plist 

DTU=`defaults read /usr/local/etc/fwcld.conf desktopOwner`
GRP=`staff`

plutil -convert xml1 /usr/local/etc/fwcld.conf.plist
mv -f /usr/local/etc/fwcld.conf.plist /usr/local/etc/fwcld.conf

chmod -R 755  /usr/local/etc/fwcld.conf



if [ -d /Users/$DTU/ ];
	then

	##change owner and group of all file within the target location of this script

	chown -R $DTU:$GRP "/Users/$DTU/"
	##chown -R $DTU:$DTU 
	##chown -R $DTU:$DTU 
	##chown -R $DTU:$DTU 
	
fi

	##remove this script afterwards
	
	##rm -f /Path of the Script