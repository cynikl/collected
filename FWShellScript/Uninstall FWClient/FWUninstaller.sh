#!/bin/sh

##9.26.08
##Kills the client, removes all FileWave software (including the catalog and anything inactive)
##The system will stay in its current state, FW will no longer have control over any files.

##Also deletes the FileWave preferences.

/usr/bin/killall fwGUI

/bin/rm -R /var/FileWave/

/bin/rm -R /usr/local/sbin/FileWave.app

/bin/rm /usr/local/etc/fwcld.conf

##This will remove files on OSX Tiger

/bin/rm -R /System/Library/StartupItems/FWClient/

##This will remove files installed from version 3.5

/sbin/fwcontrol

##This will remove files on OSX Leopard

/System/Library/LaunchAgents/com.filewave.fwGUI.plist

/System/Library/LaunchDaemons/com.filewave.fwcld.plist

##Uncomment the next line if you want to delete the log files as well

#/bin/rm /var/log/fwcld*

/bin/sleep 5

/bin/rm /usr/local/etc/FWUninstaller.sh

/usr/bin/killall fwcld