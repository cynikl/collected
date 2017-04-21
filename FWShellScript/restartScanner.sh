#!/bin/sh

# script to stop and start Filewave Scanner for Scanner version 9.0.x

fpid=`ps -awx | grep AssetScanner | grep -v grep | awk '{print $1}'`

if [ -n "$fpid" ]; then

	kill -TERM $fpid
	
fi

sleep 3

# depricated with 10.4+
rm -rf /System/Library/StartupItems/ATScanner

# Remove old asset scanner from 8.0.x
if [ -d /usr/local/sbin/AssetTrusteeXScanner.app ]; then
	rm -rf /usr/local/sbin/AssetTrusteeXScanner.app
fi

rm -rf /System/Library/LaunchAgents/com.filewave.AssetScanner.plist

# Force a full scan to happen the next time the scanner starts
rm -rf /var/AssetScanner/COLLDATA/Asset*

/usr/bin/open /usr/local/sbin/FileWaveScanner.app


