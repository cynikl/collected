#!/bin/bash

#Adds SophosUIServer to /Library/Preferences/loginwindow.plist
#for appropriate deployment via FileWave


#Test to see if entry already exists
if [[ `usr/libexec/PlistBuddy -c "Print" /Library/Preferences/loginwindow.plist | grep "SophosUIServer.app" ` ]]

#If it exists, exit
then
	exit 0

#If it does not exist, add appropriate entries
else
	/usr/libexec/PlistBuddy -c "Add :AutoLaunchedApplicationDictionary array" /Library/Preferences/loginwindow.plist
	/usr/libexec/PlistBuddy -c "Add :AutoLaunchedApplicationDictionary:0 dict" /Library/Preferences/loginwindow.plist
	/usr/libexec/PlistBuddy -c "Add :AutoLaunchedApplicationDictionary:0:Hide bool false" /Library/Preferences/loginwindow.plist
	/usr/libexec/PlistBuddy -c "Add :AutoLaunchedApplicationDictionary:0:Path string "/Library/Sophos\ Anti-Virus/SophosUIServer.app"" /Library/Preferences/loginwindow.plist

	/usr/bin/plutil -convert binary1 /Library/Preferences/loginwindow.plist
fi

#Remove script file
/bin/rm /usr/local/etc/fw_work/sophos_loginitem.sh

exit 0
