#!/bin/bash
#unix shell script to remove open firmware password
#script runs under Mac OSX 10.4, 10.5. Running script under 10.6 requires rosetta to be insalled

#this script requires the OFPW tool placed in /usr/local/ets/fw_work/

#$securitypwd should be empty
securitypwd=""

/usr/local/etc/fw_work/OFPW -pass blablabla # this is required...
/usr/local/etc/fw_work/OFPW -mode 0  

/usr/sbin/nvram security-password=$securitypwd

#finds and removes script after execution
find /usr/local/etc/fw_work/ -name "remove_ofpw.sh"