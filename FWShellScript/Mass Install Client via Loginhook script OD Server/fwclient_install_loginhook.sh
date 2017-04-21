#!/bin/sh

MYGATEWAY="$(netstat -nr | grep default | awk '{ print $2 }')"

case "$MYGATEWAY" in
        10.84.8.1) MYSCHOOL="DCHS" ;;
        10.84.32.1) MYSCHOOL="DJHS" ;;
        10.84.48.1) MYSCHOOL="DSHS" ;;
        10.80.232.1) MYSCHOOL="ADMIN" ;;
        10.84.248.1) MYSCHOOL="TRANS" ;;
        10.85.8.1) MYSCHOOL="DMS" ;;
        10.85.32.1) MYSCHOOL="GMS" ;;
        10.85.48.1) MYSCHOOL="KMS" ;;
        10.85.72.1) MYSCHOOL="SMS" ;;
        10.86.8.1) MYSCHOOL="ACES" ;;
        10.86.32.1) MYSCHOOL="BES" ;;
        10.86.48.1) MYSCHOOL="DRES" ;;
        10.86.72.1) MYSCHOOL="DWES" ;;
        10.86.88.1) MYSCHOOL="EPES" ;;
        10.86.112.1) MYSCHOOL="GRES" ;;
        10.86.128.1) MYSCHOOL="GTES" ;;
        10.86.152.1) MYSCHOOL="IRES" ;;
        10.86.168.1) MYSCHOOL="OSES" ;;
        10.86.192.1) MYSCHOOL="RES" ;;
        10.86.208.1) MYSCHOOL="SCES" ;;
        10.86.232.1) MYSCHOOL="WES" ;;
        *) MYSCHOOL="UNKNOWN" ;;
esac


#############################
###INSTALL FILEWAVE CLIENT###
#############################

LOGPREFIX="FileWaveClient Install:"
LOGFILE=/var/log/fw_client_install.log
pw=XXXXXXX

exec >>$LOGFILE 2>&1

# See if FileWave Client is already installed
if [ -e /usr/local/sbin/FileWave.app ]; then
	echo "`date` $LOGPREFIX  FileWaveClient is already installed! Canceling Installation" > $LOGFILE
	exit
else
	echo "`date` $LOGPREFIX  FileWave Client not installed, proceeding with installation" >> $LOGFILE
fi

# Create path to building server
echo "`date` $LOGPREFIX  Building is $MYSCHOOL" >> $LOGFILE
if [ $MYSCHOOL = "ADMIN" -o $MYSCHOOL = "TRANS" -o $MYSCHOOL = "UNKNOWN" ]; then
	server=update.dublinschools.net
else
        server=update.$MYSCHOOL.dublinschools.net
fi
echo "`date` $LOGPREFIX  Server path is $server" >> $LOGFILE

# Create SMB mount to update server in the building
if [[ ! -d /Volumes/smb/ ]]; then
	mkdir /Volumes/smb/
fi
mount -t smbfs //dsadmin:$pw@$server/Data /Volumes/smb
echo "`date` $LOGPREFIX  Installer sharepoint mounted" >> $LOGFILE
   
# Download Client package from update server to tmp folder
cp -R /Volumes/smb/Packages/FileWave_Client_Dublin.pkg /tmp/
echo "`date` $LOGPREFIX  Installer pkg copied" >> $LOGFILE

# Install FileWave Client
echo "`date` $LOGPREFIX  Beginning installation of FileWave Client" >> $LOGFILE
installer -pkg /tmp/FileWave_Client_Dublin.pkg -verbose -target / >> $LOGFILE


# Remove files and unmount sharepoint
rm -Rf /tmp/FileWave_Client_Dublin.pkg
umount /Volumes/smb
echo "`date` $LOGPREFIX  Installer pkg removed and sharepoint unmounted" >> $LOGFILE
echo "`date` $LOGPREFIX  FileWave Client installation completed" >> $LOGFILE
	
exit 0
