#!/bin/bash

# This script will create a login Item

/usr/bin/osascript -e 'tell application "System Events" to make new login item with properties { path: "Applications/ClamXav.app/Contents/Resources/ClamXavSentry.app", hidden:false } at end'


find / -name createloginitem.sh -exec rm -fr {} \;