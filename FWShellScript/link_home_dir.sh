#!/bin/sh

# This Script will create a link for a given user account home dir
# from /User to an arbitrary dir

# No need to edit these variables

# Username is passed in as an argument
SHORT_USER_NAME=$1

# Resolve users home folder, wherever it may be
AD_USER_DIR=`finger $SHORT_USER_NAME | grep Directory | expand | cut -d ' ' -f 2`

if [ ! -e "/Users/$SHORT_USER_NAME" ] && [ $SHORT_USER_NAME != "root" ]
then
	ln -s $AD_USER_DIR /Users/$SHORT_USER_NAME
fi
