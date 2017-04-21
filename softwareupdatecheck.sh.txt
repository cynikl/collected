#!/bin/sh
#KrisPayne, from slack macadmin, 13/02/16
softwareUpdateCheck="$( /usr/sbin/softwareupdate -l | grep -ic "No new software available." )"
    if [[ "$softwareUpdateCheck" -eq 0 ]]; then
        printf "Software is up to date.\n"
    else
        printf "Installing Software Updates.\n"
        # /usr/sbin/softwareupdate -i -a -v
    fi