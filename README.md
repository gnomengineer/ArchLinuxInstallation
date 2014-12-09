## PRE-REQUIREMENTS

#### ENABLING NETWORK
after you have installed your basic ArchLinux system you might want to create your
network access. If you get in some trouble copy the following command to your root shell

`# systemctl enable dhcpcd

and reboot your system.

#### GET GIT AND REPO

After you configured your internet connection it's time to get git and this repo. Type the following
code into your shell

`# pacman -S git

and execute this command after the successful installation of git

`# git clone https://github.com/troopa/ArchLinuxInstallation.git

#### ENABLING REPOSITORIES

for using the script included in this package
you must enable required repositories in your
/etc/pacman.conf  
if you're using a 64-bit system the [multilib] repo is
recommended. It is also needed for skype and icedtea-web  
use this command to edit your pacman.conf
`# vi /etc/pacman.conf

*NOTE: this script is not intended for root user. execute it with a regular user*

----------------------------------------------------------------------------------
## USAGE

the use of the script is structured like
	
`$ ./pacinstall.sh packages/package_list.txt`

the 1st and only parameter is the list of packages.

After the script has finished a log will appear in the directory where
the script was executed. In this log are all messages during the script runtime
written, inclusive all error messages.

*NOTE: the log file should be checked in any case*

----------------------------------------------------------------------------------
## POST-CONFIGURATION


#### GRAPHIC CARD

depending on your hardware you can add the packages of your  
graphic card to the package list.  
if you use NVIDIA the following command generates a basic xorg.conf  

`# nvidia-xconfig`

for ATI/AMD graphic card drivers you can use this command to generate an xorg.conf  

`# Xorg -configure`


#### USER CREATION

useful groups for a "local admin" user like a regular windows user with additional rights

users - standard users group  
audio - access group for sound hardware (required for ALSA and OSS)  
video - access to video captures devices, 2D/3D hardware acceleration etc.  
wheel - administration group  
storage - access to removable drives such as USB etc,  
optical - access to CD or DVD drives  
power - rights to use suspend and other power management controls  
network - right to change network settings  
log - access to /var/log  

the user is created with this command

`# useradd -m -G users,audio,video,wheel,storage,optical,power,network,log -s /bin/bash <username>`


#### PULSEAUDIO

in order to use the package "pavucontrol" you need to start the pulseaudio server. If it does not start automatically insert
`pulseaudio --start` into your ~/.xinitrc file before your window manager command

*Note: If you plan to use moc as your music player I do not recommend using pulseaudio!*
