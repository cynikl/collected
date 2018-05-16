#!/bin/sh

#This script will turn off SSL Encription and restart the FileWave Client



	CFPATH=/usr/local/etc

	/sbin/fwcontrol client stop
	
	SSLoff=0

	defaults write $CFPATH/fwcld useSSL "$SSLoff"
	
	plutil -convert xml1 $CFPATH/fwcld.plist
	
	chmod -R 755  $CFPATH/fwcld.plist

	/sbin/fwcontrol client start
