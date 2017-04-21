#!/bin/bash 
# The dns entry (or IP address) for the FileWave XServer 
FWXSERVER="repositoryx.wsl.ch" 
# The (default) path to the servers Data Folder 
SERVERPATH="/fwxserver/Data\ Folder/" 
# The (default) path to the Boosters Data Folder. Note the ending without a slash 
LOCALPATH="/var/FWBooster/Data Folder" 
# The shortname for a valid user on the XServer 
# This user only needs read access to the Data Folder - which is a good idea 
SERVERUSER="administrator" 
# The (default) path to the rsyncX binary
RSYNCX="/usr/bin/rsync" 
# Here's the command that copies all the files 
# If you want a backup of your database, just delete the "--exclude=" for 
# the database files/folders 
# The -v option is for "verbose mode", and can be excluded 
sudo $RSYNCX -av -e ssh --rsync-path=$RSYNCX --exclude='.DS_Store' --exclude='*.idx' --exclude='*.dat' --exclude='ADMINWORK/*' --exclude='MANIFESTS/*' $SERVERUSER@$FWXSERVER:"$SERVERPATH" "$LOCALPATH"