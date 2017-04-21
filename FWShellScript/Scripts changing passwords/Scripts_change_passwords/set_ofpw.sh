#!/bin/bash
#unix shell script to remove open firmware password
#script runs under Mac OSX 10.4, 10.5. Running script under 10.6 requires rosetta to be insalled

#this script requires the OFPW tool placed in /usr/local/ets/fw_work/

# To get the security password, you have to set it on a computer (using Apple's
# Open Firmware # Password utility) and then type "sudo nvram security-password"
# in the terminal.  Paste the result into $security_password below. Note, it 
# should look something like "%00%00%00%00%00%00%00%00" except other charaters
# instead of the 0's.

#set your new firmware password here in (hard coded but encrypted) 
securitypwd="%cc%c3%c6%cf%dd%cb%dc%cf"

/usr/local/etc/fw_work/OFPW -pass blablabla # this is goofy, but required...
/usr/local/etc/fw_work/OFPW -mode 1  

/usr/sbin/nvram security-password=$securitypwd


# finds and removes script after execution
find /usr/local/etc/fw_work/ -name "set_adminpw.sh"