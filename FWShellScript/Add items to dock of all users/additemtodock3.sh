#!/bin/bash

#############################
###                       ###
###   Add Items to Dock   ###
###                       ###
#############################

#This is a simple script to add items to dock of all existing users

#Script edited by Maid Grbic FileWave (Europe) GmbH Oct.01.2009

#Please add the full path of the application you want to add to the dock
item="/Applications/Safari.app"

for eachPath in `/usr/bin/find /Users/* -maxdepth 0`

do

homeown=`echo $eachPath | cut -d/ -f3`

#Check if application already exists in the dock. If yes then the application won't be added twice
    application_check1=`defaults read /Users/$homeown/Library/Preferences/com.apple.dock persistent-apps | grep -w _CFURLString | awk 'BEGIN { FS = "\"" } ; { print $4 }' | grep -x $item`
    application_check2=`defaults read /Users/$homeown/Library/Preferences/com.apple.dock persistent-apps | grep -w _CFURLString | awk 'BEGIN { FS = "\"" } ; { print $4 }' | grep -x $item/`
    if [ "${application_check1}" != "" ] || [ "${application_check2}" != "" ] ; then
        echo "WARNING! : Application is already in the dock, it will not be added again : $item"
        
    else
      
       if [ -d $item ] || [ -f $item ] ; then
        #echo "Adding Applicatrion : $item"
        defaults write /Users/$homeown/Library/Preferences/com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$item</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"        
    else
        echo "WARNING! : Could not locate Application : $item"
    fi
      
      
    fi
    
#Repair Permissions
chown -R $homeown:staff /Users/$homeown/Library/Preferences/com.apple.dock.plist
chmod 755 /Users/$homeown/Library/Preferences/com.apple.dock.plist


done

#Restart Dock
killall Dock

exit 0