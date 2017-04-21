ULabMin 0.7.3  (last updated 2005.02.24)

ULabMin is a collection of scripts, modifications, tools,
graphics, etc., that the University of Utah's Student
Computing Labs uses on their student Macintosh lab computers.

http://www.macos.utah.edu/ulabmin/

You need to do many things before you install ULabMin!

DON'T JUST INSTALL AND REBOOT!  YOU WILL REGRET IT.

If you are upgrading, then skip to "About old settings
and backed up system files"

--------------------------------------------------
--------------------------------------------------
BEFORE you install:
--------------------------------------------------
--------------------------------------------------

- Install the OS and create an admin user
- Run Software Update
- Configure Kerberos/LDAP/whatever
- Setup System Preferences
	Set energy saver defaults
	Set an ip default
	Set up a date/time default
	HINT: Account "Login Option" settings are BYPASSED
	      by ULabMin, so don't bother setting them

- Create a non-admin user (you can do this later on, but it
  is easier if you do it first)

- If you are using radmind, it would be a good time to
  create a base overload of your machine.

- Install 3rd party software that might be required by
  ULabMin (if you are using radmind, it would be a good
  idea to create overloads of each of these apps)

	FruitMenu - Required if you want to change the Apple
	Menu, NOT FREE--There is a way to hack the 
	AppleMenu nib if all you want is to *remove* items
	from it

	Menuversum - Required if you want a menu bar 
	radmind status graphic

	ncutil 2.x - Required if you want to change the
	computer name and other network settings

	Radmind - Required if you want to manage your
	computer nicely

	iHook - Required if you use Radmind

	Screen Preserver - Required if you want to have a
	screen saver over the login window
	
	SecureIt - Required if you want to lock single user
	mode a little more

	Anything else you have

- Configure 3rd party software

	FruitMenu needs a "FruitMenu Items" folder

	Screen Preserver requires 1024 x 768 screen saver
	graphics (see Screen Preserver readme)

	Anything else you have


- If you are using radmind, before you install, it
  would be a VERY good idea to create an overload
  of *everything* up to this point.
  
- If you are using radmind, it is a good idea to create
  an overload of ***ONLY*** ULabMin, and you can't do
  that if you don't have overloads of everything up to
  this point.

--------------------------------------------------
--------------------------------------------------
AFTER you install:
--------------------------------------------------
--------------------------------------------------

Any old settings that you have will be archived in
/etc/ulabmin/old.  System files that are replaced by
the installer or when ULabMin runs will also be moved
into that location (and /etc/ulabmin -- see below).

First you must configure ULabMin.

Then you should create an image (either ARD or with radmind).

Then you need to run
/Library/ULabMin/Private/scripts/post_maintenance.pl
before actually getting the exact behavior that ULabMin
is suppose to support.

------------------------------------------------
About old settings and backed up system files:
------------------------------------------------

The installer will back up the ULabMin settings and files,
and some system files that ULabMin replaces when it runs.
They are located in /etc/ulabmin/old.

Everything else is stored in /etc/ulabmin/old.

If you have made modifications of any of the backed up
files, you will want to compare the files and sync any
changes you have made.  If the files you have modified
are replaced by ULabMin as it runs, then that means
that ULabMin manages the file.  There are settings
inside of ulabmin's config files to manage the contents
of the file.

If you are upgrading ULabMin, you will need to compare
the old config files with the new (with BBEdit or
something) and sync the changes.  Right now this is the
ONLY way to preserve your settings. SORRY. I know this
sucks. I do the same thing with my files (maybe a
slightly different process), so you are not alone.

------------------------------------------------
Configure ULabMin for the first time:
------------------------------------------------

ulabmin_global_config.pl
ulabmin_global_config.sh
ulabmin_machine_config.pl

Change settings in these files:
	/etc/ulabmin/ulabmin_machine_config.pl
		Is this computer a lab/kiosk/presentation 
		computer? Is this computer authenticated or
		autologin? Uncomment the appropriate stuff.
		Etc.

		NOTE: this file is designed to be the only file
		that requires customization for different
		machine configurations you manage, so you may
		have several of these files depending on the
		configuration.

	/etc/ulabmin/ulabmin_global_config.sh
		Set the $phone_home_url
		Set the $radmind_master
		Set the usernames and home folders that you 
			setup before (you may need to edit the 
			NetInfo settings with NetInfo Manager here)
		Etc.

		NOTE: this file is designed to be shared by all of
		your computers, no matter what the configuration
		is.  If you have settings that are different between
		two configurations, put that stuff in the section at
		the bottom of the file in a subroutine (see the
		many examples already there).  Then in the file
		ulabmin_machine_config.pl call the appropriate
		subroutines for the appropriate configurations.
		
	
	/etc/ulabmin/ulabmin_global_config.sh
		You can turn on or off various parts of ULabMin in
		this file.  This file is used by shell scripts that
		are a part of ULabMin.  You shouldn't need to
		change this file unless you turn of various stuff.
		
		NOTE: this file is designed to be shared by all of
		your computers.

	/etc/ulabmin/report_to_master_config.sh
		Change URL, username, and password--hard
		coded :(

	There are other files in /etc/ulabmin that you will
	probably want to edit.

Optional, add your own custom graphics--see the
"Graphics" folder

------------------------------------------------
Creating an image (radmind)
------------------------------------------------

I have included a transcript that we use for radmind.
You probably can't just upload it because of prebinding.
But you could try.  There is also a script that is used to
create a ULabMin overload and upload it.

You want to create an overload BEFORE running any other
scripts and such because ULabMin will make changes and
you don't want most of the changes uploaded.

You WILL want a seperate overload for settings, both global
and machine config.  For example, We have one overload
(for all machines) that has only this file (which we updated
pretty often):

a ./private/etc/ulabmin/ulabmin_global_config.pl 0640 0 0 1107403940 32500 NHz0FbprH32LIwiZpreM1h9hcxY=

And a seperate overload for (we have many overloads
with just this file, and this is how we customize ULabMin
for each machine configuration--and we RARELY modify
these overloads, we modify ulabmin_global_config.pl
when we want to change a machine's behavior):

f ./private/etc/ulabmin/ulabmin_machine_config.pl 0640     0    80 1104190258    1867 ka/RVNlPTLLaQPUgYChKhXl5uV4=

Our global settings include more than just the
ulabmin_global_settings.pl file, but alot of other stuff
that we (RARELY) modify.  It looks like this:

l ./Library/Admin /Library/ULabMin/User\bTools

f ./System/Library/CoreServices/SecurityAgentPlugins/loginwindow.bundle/Contents/Resources/English.lproj/login.nib/info.nib 0644     0     0 1089754149    1378 FUFQQhPRTDtDGUqqzuODOXSyCjg=

f ./System/Library/CoreServices/SecurityAgentPlugins/loginwindow.bundle/Contents/Resources/English.lproj/login.nib/objects.nib 0644     0     0 1089754163   16469 jxK6agB2EZ8BDudSev5JDyis2Og=

l ./Users/mac/Desktop/Run\bMaintenance /Library/ULabMin/User\bTools/Run\bMaintenance 

l ./Users/mac/Desktop/ULabMin /Library/ULabMin

f ./private/etc/hosts.allow             0640     0     0 1089672368     379 9kSsaEnwNr2W/gNw3Q0zpey+ioo=

f ./private/etc/sshd_config             0600     0     0 1089672560    2397 cIsKKW4GysUAiyjxj8PNZ6Z77xQ=

f ./private/etc/sudoers                 0440     0     0 1089672585     342 O25Nvxst64f6jkZLt9W/cZyfcMo=

d ./private/etc/ulabmin                 0755     0     0

f ./private/etc/ulabmin/computer_names  0640     0    80 1083702556      35 OhPVT6Qt+mmTZwAOnFxHQrBAA9o=

f ./private/etc/ulabmin/create_overload_filter 0640     0     0 1089672634     918 gx1KRR7y/4kqz2PCIYO2zIXrcXc=

a ./private/etc/ulabmin/login_denied.png            0640 0   0 1105748900  104446 zzbtloUGhRnj6JB+Nh5NOofDmBc=

f ./private/etc/ulabmin/objects.nib     0640     0    80 1072201814   16400 Q5DX8APlxFgKITahQiGRDWOsyoM=

f ./private/etc/ulabmin/performing_maintenance1.gif 0640     0    80 1074732720   29945 dfL9NlaP/CB1qqlFtiAtLGsVR6g=

f ./private/etc/ulabmin/performing_maintenance2.gif 0640     0    80 1074732720   29659 rFKAd2cBGa2Iaf8rIa4dMBU664U=

f ./private/etc/ulabmin/performing_maintenance3.gif 0640     0    80 1074732720   30134 mmseI38RPEffJvK7RGxV5QR0C9g=

f ./private/etc/ulabmin/performing_maintenance4.gif 0640     0    80 1074732720   27798 2Shk9Xlkn4oXacJv+mN4OXDVyZc=

f ./private/etc/ulabmin/performing_maintenance5.gif 0640     0    80 1074732720   28503 dW1HKa2A7mSel5yv6ls9mY9BseM=

f ./private/etc/ulabmin/rc.firewall     0640     0    80 1096652674    3845 +rxxYD1mTthpcz3MDTmvoMAYTvM=

f ./private/etc/ulabmin/report_to_master_config.sh 0600     0    80 1105400219    1360 6KYnY0rsZADP+smy8ow77syZbqg=

f ./private/etc/ulabmin/ulabmin_global_config.sh 0640     0     0 1093649335    5384 oxXxfAghFd/L9Ve48mozG0TxsXM=

------------------------------------------------
Taking the blind leap....
------------------------------------------------

When you are ready to actually test this, well, first you
should put a net below you so that if something fails,
you don't have to resort to force restarting the computer,
booting to single user mode, or booting off of a firewire
drive (all of those suck and you should avoid them!!).

First, enable ARD or SSHD!  Make sure you can get sudo
access and edit files before proceeding!  It is a good idea
to ALWAYS have this access (ARD shouldn't be so bad to
ask for...). When you are finally ready, run the script:

/Library/ULabMin/Private/scripts/post_maintenance.pl

Then reboot.

Your computer should now be functioning in a very
Borgified manner.  If you have created radmind overloads
of everything, run radmind.  It should go through
everything and come up in the same Borgified manner
when it is done.

--------------------------------------------------
--------------------------------------------------
Known issues:
--------------------------------------------------
--------------------------------------------------

Known issues:

------------------------------------------------
Too steep a learning curve?  Too little documentation?

------------------------------------------------
Lots of stuff is buggy.  But it's getting better...

------------------------------------------------
Upgrading sucks.

------------------------------------------------
Startup WILL hang if the ULabMin startup item 
(/Library/StartupItems/ULabMin/ULabMin)
gets an error!  Make sure you have sshd or ARD running
before rebooting!!!  Don't just install and reboot!

If it does get an error and you don't have SSHD or ARD
running, you will have to force reboot, boot to single user
mode or boot to a different hard disk (firewire), or mount
the hard disk to another computer (firewire target disk mode).

Then you will need to disable
/Library/StartupItems/ULabMin/ULabMin by editing

/etc/ulabmin/ulabmin_global_settings.sh (sh not pl).

Change:

ULABMIN_STARTUP=1

to

ULABMIN_STARTUP=0

Then reboot, and when it comes up (it should come up this
time) you can login as admin and then open Terminal and
manually run
/Library/ULabMin/Private/scripts/startup_script.pl

It should get an error, and you can then debug it (email
to the sourceforge list if this is over your head).

------------------------------------------------
In Kiosks, if you did something wrong (which is easy since
the documentation isn't very organized) you could be
staring at a blue screen and nothing else when it boots up.

------------------------------------------------
Not much of this has been tested outside of the U of U's
default configuration.  So we haven't tested absolute
radmind paths ("/" instead of ".").  We haven't tested an
autologin lab computer (although it should work).  We
rename our apps and move them so if you don't, you may
notice a bug in the scripts (it has happened before). Etc.
