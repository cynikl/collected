#!/bin/sh

# script to keep computers from showing up in screen sharing

defaults write /Library/Preferences/com.apple.RemoteManagement VNCNoRegister -bool yes

