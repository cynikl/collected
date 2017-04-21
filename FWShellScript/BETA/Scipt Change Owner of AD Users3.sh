#!/bin/sh
##BETA Script to change Owner of AD users
##This script requires the Fileset 'Change DesktopOwner by login' to be first deployed
##This script has to be deployed with FileWave to /Users/.
##All files within the same directory as this file will be changed (owner and group)

##Read the user name of the logged in user from /usr/local/etc/fwcld.conf
mv -f /usr/local/etc/fwcld.conf /usr/local/etc/fwcld.conf.plist 

DTU=`defaults read /usr/local/etc/fwcld.conf desktopOwner`

plutil -convert xml1 /usr/local/etc/fwcld.conf.plist
mv -f /usr/local/etc/fwcld.conf.plist /usr/local/etc/fwcld.conf

chmod -R 755  /usr/local/etc/fwcld.conf



if [ -d /Users/$DTU/ ];
	then

	##----->HIER PFAD ANPASSEN
	PTF="/Users/$DTU/Desktop/test/"
	##PTF1="/Users/$DTU/Desktop/test1/"
	##PTF2="/Users/$DTU/Desktop/test2/"
	##PTF3="/Users/$DTU/Desktop/test3/"

	##change owner and group of all file within the target location of this script

	chown -R $DTU:$DTU $PTF
	##chown -R $DTU:$DTU $PTF1
	##chown -R $DTU:$DTU $PTF2
	##chown -R $DTU:$DTU $PTF3
	
fi

	##remove this script afterwards
	PTS=`find /Users -type f -name 'chownfw.sh'`
	rm $PTS