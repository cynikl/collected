#!/bin/sh
# firstboot.sh
# Created by Amsys
#
# Use at your own risk.  Amsys will accept
# no responsibility for loss or damage
# caused by this script.

# Requires 10.10 or higher.

###############
## variables ##
###############
PLBUDDY=/usr/libexec/PlistBuddy
KEYBOARDNAME="British"
KEYBOARDCODE="2"
LANG="en" #fr
REGION="en_GB" #fr_CH
ARD="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
SUBMIT_TO_APPLE=NO
SUBMIT_TO_APP_DEVELOPERS=NO

##############################################################
######### Advanced Modification Only Below This Line #########
##############################################################

###############
## functions ##
###############

update_kdb_layout() {
  ${PLBUDDY} -c "Delete :AppleCurrentKeyboardLayoutInputSourceID" "${1}" &>/dev/null
  if [ ${?} -eq 0 ]
  then
    ${PLBUDDY} -c "Add :AppleCurrentKeyboardLayoutInputSourceID string com.apple.keylayout.${KEYBOARDNAME}" "${1}"
  fi

  for SOURCE in AppleDefaultAsciiInputSource AppleCurrentAsciiInputSource AppleCurrentInputSource AppleEnabledInputSources AppleSelectedInputSources
  do
    ${PLBUDDY} -c "Delete :${SOURCE}" "${1}" &>/dev/null
    if [ ${?} -eq 0 ]
    then
      ${PLBUDDY} -c "Add :${SOURCE} array" "${1}"
      ${PLBUDDY} -c "Add :${SOURCE}:0 dict" "${1}"
      ${PLBUDDY} -c "Add :${SOURCE}:0:InputSourceKind string 'Keyboard Layout'" "${1}"
      ${PLBUDDY} -c "Add :${SOURCE}:0:KeyboardLayout\ ID integer ${KEYBOARDCODE}" "${1}"
      ${PLBUDDY} -c "Add :${SOURCE}:0:KeyboardLayout\ Name string '${KEYBOARDNAME}'" "${1}"
    fi
  done
}

update_language() {
  ${PLBUDDY} -c "Delete :AppleLanguages" "${1}" &>/dev/null
  if [ ${?} -eq 0 ]
  then
    ${PLBUDDY} -c "Add :AppleLanguages array" "${1}"
    ${PLBUDDY} -c "Add :AppleLanguages:0 string '${LANG}'" "${1}"
  fi
}

update_region() {
  ${PLBUDDY} -c "Delete :AppleLocale" "${1}" &>/dev/null
  ${PLBUDDY} -c "Add :AppleLocale string ${REGION}" "${1}" &>/dev/null
  ${PLBUDDY} -c "Delete :Country" "${1}" &>/dev/null
  ${PLBUDDY} -c "Add :Country string ${REGION:3:2}" "${1}" &>/dev/null
}


#####################
## Script Commands ##
#####################

# Create a local admin user account
sysadminctl -addUser localadmin -fullName "Local Admin" -UID 499 -password "apassword" -home /var/localadmin -admin

# Set the time zone to London
/usr/sbin/systemsetup -settimezone "Europe/London"

# Enable network time servers
/usr/sbin/systemsetup -setusingnetworktime on

# Configure a specific NTP server
/usr/sbin/systemsetup -setnetworktimeserver "ntp.amsys.co.uk"

# Change Keyboard Layout
update_kdb_layout "/Library/Preferences/com.apple.HIToolbox.plist" "${KEYBOARDNAME}" "${KEYBOARDCODE}"

for HOME in /Users/*
  do
    if [ -d "${HOME}"/Library/Preferences ]
    then
      cd "${HOME}"/Library/Preferences
      HITOOLBOX_FILES=`find . -name "com.apple.HIToolbox.*plist"`
      for HITOOLBOX_FILE in ${HITOOLBOX_FILES}
      do
        update_kdb_layout "${HITOOLBOX_FILE}" "${KEYBOARDNAME}" "${KEYBOARDCODE}"
      done
    fi
done

# Set the computer language
update_language "/Library/Preferences/.GlobalPreferences.plist" "${LANG}"

for HOME in /Users/*
  do
    if [ -d "${HOME}"/Library/Preferences ]
    then
      cd "${HOME}"/Library/Preferences
      GLOBALPREFERENCES_FILES=`find . -name "\.GlobalPreferences.*plist"`
      for GLOBALPREFERENCES_FILE in ${GLOBALPREFERENCES_FILES}
      do
        update_language "${GLOBALPREFERENCES_FILE}" "${LANG}"
      done
    fi
done

# Set the region
update_region "/Library/Preferences/.GlobalPreferences.plist" "${REGION}"

for HOME in /Users/*
  do
    if [ -d "${HOME}"/Library/Preferences ]
    then
      cd "${HOME}"/Library/Preferences
      GLOBALPREFERENCES_FILES=`find . -name "\.GlobalPreferences.*plist"`
      for GLOBALPREFERENCES_FILE in ${GLOBALPREFERENCES_FILES}
      do
        update_region "${GLOBALPREFERENCES_FILE}" "${REGION}"
      done
    fi
done

# Switch on Apple Remote Desktop
$ARD -configure -activate

# Configure ARD access for the localadmin user
$ARD -configure -access -on
$ARD -configure -allowAccessFor -specifiedUsers
$ARD -configure -access -on -users localadmin -privs -all

# Enable SSH
systemsetup -setremotelogin on

# Configure Login Window to username and password text fields
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true

# Enable admin info at the Login Window
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable External Accounts at the Login Window
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow EnableExternalAccounts -bool false

# Disable iCloud for logging in users
osvers=$(sw_vers -productVersion | awk -F. '{print $2}')
sw_vers=$(sw_vers -productVersion)

for USER_TEMPLATE in "/System/Library/User Template"/*
	do
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenBuddyBuildVersion "${sw_build}"
	done

for USER_HOME in /Users/*
	do
		USER_UID=`basename "${USER_HOME}"`
		if [ ! "${USER_UID}" = "Shared" ] 
		then 
		if [ ! -d "${USER_HOME}"/Library/Preferences ]
		then
			mkdir -p "${USER_HOME}"/Library/Preferences
			chown "${USER_UID}" "${USER_HOME}"/Library
			chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
		fi
		if [ -d "${USER_HOME}"/Library/Preferences ]
		then
			/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
			/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
			/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
			/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant LastSeenBuddyBuildVersion "${sw_build}"
			chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist
		fi
	fi
	done

# Disable diagnostics at login
if [ $osvers -ge 10 ]; then
  CRASHREPORTER_SUPPORT="/Library/Application Support/CrashReporter"
  CRASHREPORTER_DIAG_PLIST="${CRASHREPORTER_SUPPORT}/DiagnosticMessagesHistory.plist"
 
  if [ ! -d "${CRASHREPORTER_SUPPORT}" ]; then
    mkdir "${CRASHREPORTER_SUPPORT}"
    chmod 775 "${CRASHREPORTER_SUPPORT}"
    chown root:admin "${CRASHREPORTER_SUPPORT}"
  fi
 
  for key in AutoSubmit AutoSubmitVersion ThirdPartyDataSubmit ThirdPartyDataSubmitVersion; do
    $PlistBuddy -c "Delete :$key" "${CRASHREPORTER_DIAG_PLIST}" 2> /dev/null
  done
 
  $PlistBuddy -c "Add :AutoSubmit bool ${SUBMIT_TO_APPLE}" "${CRASHREPORTER_DIAG_PLIST}"
  $PlistBuddy -c "Add :AutoSubmitVersion integer 4" "${CRASHREPORTER_DIAG_PLIST}"
  $PlistBuddy -c "Add :ThirdPartyDataSubmit bool ${SUBMIT_TO_APP_DEVELOPERS}" "${CRASHREPORTER_DIAG_PLIST}"
  $PlistBuddy -c "Add :ThirdPartyDataSubmitVersion integer 4" "${CRASHREPORTER_DIAG_PLIST}"
fi

# Disable Time Machine Popups offering for new disks
/usr/bin/defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Turn off Gatekeeper
spctl --master-disable

# Turn on right-click for mouse and trackpad
for USER_TEMPLATE in "/System/Library/User Template"/*
	do
	/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.driver.AppleHIDMouse Button2 -int 2
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -int 1
done

for USER_HOME in /Users/*
	do
		USER_UID=`basename "${USER_HOME}"`
		if [ ! "${USER_UID}" = "Shared" ] 
		then 
			if [ ! -d "${USER_HOME}"/Library/Preferences ]
			then
			mkdir -p "${USER_HOME}"/Library/Preferences
			chown "${USER_UID}" "${USER_HOME}"/Library
			chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
			fi
			if [ -d "${USER_HOME}"/Library/Preferences ]
			then
				killall -u $USER_UID cfprefsd
				/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.driver.AppleHIDMouse Button2 -int 2
    			/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton
    			/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -int 1
			fi
		fi
done

# Turn off restore windows
for USER_TEMPLATE in "/System/Library/User Template"/*
	do
	/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/.GlobalPreferences NSQuitAlwaysKeepsWindows -boolean FALSE
done

for USER_HOME in /Users/*
	do
		USER_UID=`basename "${USER_HOME}"`
		if [ ! "${USER_UID}" = "Shared" ] 
		then 
			if [ ! -d "${USER_HOME}"/Library/Preferences ]
			then
			mkdir -p "${USER_HOME}"/Library/Preferences
			chown "${USER_UID}" "${USER_HOME}"/Library
			chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
			fi
			if [ -d "${USER_HOME}"/Library/Preferences ]
			then
			killall -u $USER_UID cfprefsd
			/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/.GlobalPreferences NSQuitAlwaysKeepsWindows -boolean FALSE
			fi
		fi
done

# Stop writing .DS_Store files on the network
for USER_TEMPLATE in "/System/Library/User Template"/*
	do
	/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/.GlobalPreferences DSDontWriteNetworkStores -bool TRUE
done

for USER_HOME in /Users/*
	do
		USER_UID=`basename "${USER_HOME}"`
		if [ ! "${USER_UID}" = "Shared" ] 
		then 
			if [ ! -d "${USER_HOME}"/Library/Preferences ]
			then
			mkdir -p "${USER_HOME}"/Library/Preferences
			chown "${USER_UID}" "${USER_HOME}"/Library
			chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
			fi
			if [ -d "${USER_HOME}"/Library/Preferences ]
			then
			killall -u $USER_UID cfprefsd
			/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/.GlobalPreferences DSDontWriteNetworkStores -bool TRUE
			fi
		fi
done

exit 0