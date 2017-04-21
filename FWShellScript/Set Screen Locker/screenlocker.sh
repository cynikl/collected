#!/bin/bash

#Thist Unix shell script has been written by Maid Grbic FileWave Europe (GmbH)

# Determine OS version
osVersion=`sw_vers -productVersion`;
echo "OS Version Detected: $osVersion" >>/var/log/byhostscreensaver.log

askforpwd=1;
idletime=600;
modulename=Flurry;




#we set the screensaver for all users exist on the system
for eachPath in `/usr/bin/find /Users/* -maxdepth 0`

do

	homeown=`echo $eachPath | cut -d/ -f3`
#	echo "" >>/var/log/byhostscreensaver.log
	echo "-------------------------------------------------------------" >>/var/log/byhostscreensaver.log
	echo "-------------------------------------------------------------" >>/var/log/byhostscreensaver.log
	
	date=`/bin/date`;
	echo "Login Time: $date" >>/var/log/byhostscreensaver.log
	echo "Proceed User: $homeown" >>/var/log/byhostscreensaver.log
	
	#find com.apple.screensaver
	ssfile=`find $eachPath/Library/Preferences/ByHost/com.apple.screensaver.*.plist`
	
	
	if [ ! -n "$ssfile" ]; then
	
	echo "Plist not found" >>/var/log/byhostscreensaver.log
	
	OSVERS=`sw_vers -productVersion | cut -f 2 -d .`
	if [ $OSVERS -ge 5 ]; then

		#if a plist was not yet created then create a new one
		HOSTID=`ioreg -rd1 -c IOPlatformExpertDevice | awk '/IOPlatformUUID/ { split($0, line, "\""); printf("%s\n", line[4]); }'`
		echo "Create new plist with HostID: $HOSTID" >>/var/log/byhostscreensaver.log
		
		HOSTIDMAC=`ifconfig en0 | grep ether | awk -s '{print $2}' | sed 's/://g'`
		echo "Create new plist with HostID: $HOSTID" >>/var/log/byhostscreensaver.log

		defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTIDMAC askForPassword -int $askforpwd
		 #Start screensaver after 10min
    	defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTIDMAC idleTime $idletime
    
    	#Sets screensaver Flurry
    	defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTIDMAC moduleName $modulename
    	defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTIDMAC modulePath "/System/Library/Screen Savers/Flurry.saver"
    
    	plistcnt=`defaults read $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTIDMAC`
    	echo "$plistcnt" >>/var/log/byhostscreensaver.log

    	#repairs permission of com.apple.screensaver
    	
    		
	else

		#if a plist was not yet created then create a new one
		HOSTID=`ifconfig en0 | grep ether | awk -s '{print $2}' | sed 's/://g'`
		echo "Create new plist with HostID: $HOSTID" >>/var/log/byhostscreensaver.log
	
	fi
	
	#Locks the screensaver
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID askForPassword -int $askforpwd
    
  
    #Start screensaver after 10min
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID idleTime $idletime
    
    #Sets screensaver Flurry
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID moduleName $modulename
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID modulePath "/System/Library/Screen Savers/Flurry.saver"
    
    plistcnt=`defaults read $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID`
    echo "$plistcnt" >>/var/log/byhostscreensaver.log

	 #repairs permission of com.apple.screensaver
    chown -R $homeown:staff $eachPath/Library/Preferences/ByHost
	chmod 755 $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID.plist
	chmod 755 $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTIDMAC.plist
    
    
    
	else

	
	ssfile2=`find $eachPath/Library/Preferences/ByHost/com.apple.screensaver.slideshow.*.plist`
	if [ ! -n "$ssfile2" ]; then
	
	echo "Plist found in $ssfile" >>/var/log/byhostscreensaver.log
	
	HOSTID=`echo $ssfile | sed 's/^.*screensaver\.//' | sed 's/\.plist//'`
    echo "Found HostID: $HOSTID" >>/var/log/byhostscreensaver.log
	
	#Locks the screensaver
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID askForPassword -int $askforpwd
  
    #Start screensaver after 10min
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID idleTime $idletime
    
    #Sets screensaver Flurry
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID moduleName $modulename
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID modulePath "/System/Library/Screen Savers/Flurry.saver"
    
    plistcnt=`defaults read $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID`
    echo "$plistcnt" >>/var/log/byhostscreensaver.log
	
	 
	else
	 
	HOSTID=`echo $ssfile | sed 's/^.*screensaver.slideshow\.//' | sed 's/\.plist//'`
    echo "Plist found in $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID.plist" >>/var/log/byhostscreensaver.log
    echo "Found HostID: $HOSTID" >>/var/log/byhostscreensaver.log
     
     
     
    #Locks the screensaver
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID askForPassword -int $askforpwd
  
    #Start screensaver after 10min
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID idleTime $idletime
    
    #Sets screensaver Flurry
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID moduleName $modulename
    defaults write $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID modulePath "/System/Library/Screen Savers/Flurry.saver"
    
    plistcnt=`defaults read $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID`
    echo "$plistcnt" >>/var/log/byhostscreensaver.log
     
	  
	fi
	
	 #repairs permission of com.apple.screensaver
    chown -R $homeown:staff $eachPath/Library/Preferences/ByHost
	chmod 755 $eachPath/Library/Preferences/ByHost/com.apple.screensaver.$HOSTID.plist
	
	fi
	

	
done

