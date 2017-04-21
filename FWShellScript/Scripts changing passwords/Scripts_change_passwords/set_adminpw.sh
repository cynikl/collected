#!/bin/bash
#unix shell script to set/change user password
#script runs under Mac OSX 10.4, 10.5, 10.6

#define here in your new user password
password="filewave"

/usr/bin/dscl . passwd /Users/Administrator $password

#NOTE- you must use the full path of where the user is located
#if you have a non standard path, like in /private/var you must use that
#replace password with desired password

# finds and removes script after execution
find /usr/local/etc/fw_work/ -name "set_adminpw.sh"