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

##target location of this script
PTS=`find /Users -type f -name 'chownfw.sh'`

D=$(dirname $PTS)

##change owner and group of all file within the target location of this script
chown -R $DTU:$DTU $D/

##remove this script afterwards
rm $PTS