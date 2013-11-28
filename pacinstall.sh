#!/bin/bash

#author: Daniel Föhn aka (Don) Troopa
#date: 2013-11-28
#desc: a script that installs package from a given list.
#call:	pacinstall package_list.txt 

folder=$(pwd)
success=true
logfile="$folder/pacinstall.log"

### START LOG FILE HEADER ###
{ echo "log file for bash script 'pacinstall'"
echo "last script runtime: $(date %c)"
echo "[EE] Error in process, [WW] Warning in process, [II] normal Information"
echo "script was run in directory $folder"
echo "\n"
} > $logfile
### END LOG FILE HEADER ###

### START OF INSTALLATION PROCESS ###
echo "start installing programs ..."
sleep 2
#install yaourt so all programms can be installed either from AUR
cd /tmp
wget http://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
tar -xzf package-query.tar.gz
wget http://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
tar -xzf yaourt.tar.gz
#do following only when package-query was successfully extracted
if test -d /tmp/package-query
then
        cd package-query/
        sudo pacman -S yajl --noconfirm
        makepkg
        sudo pacman -U *.xz --noconfirm
		#checks if package-query was installed correctly
		package=$(pacman -Qq package-query)
		if [ $package == "" ]
		then
			echo "[EE] package-query was not installed" >> $logfile
			success=false
		fi
else
        echo "[EE] /tmp/package-query could not be created" >> $logfile
		success=false
fi

if test -d /tmp/yaourt && $success
then
        cd /tmp/yaourt/
        makepkg
        sudo pacman -U *.xz --noconfirm
		#checks if yaourt is installed correctly
		package=$(pacman -Qq yaourt)
		if [ $package == "" ]
		then
			echo "[EE] yaourt was not installed" >> $logfile
			success=false
		fi
else
        echo "[EE] /tmp/yaourt could not be created" >> $logfile
		success=false
fi

#intall all packages with yaourt
if [ $success ]
then
	while read zeile
	do
	set $zeile
			if [ $(echo $zeile | cut -c 1) != "#" ]
			then
					yaourt -S $zeile --noconfirm
					package=$(pacman -Qq $zeile)
					if [ $package == "" ]
					then
							echo "[WW] $zeile was not installed correctly" >> $logfile
							success=false;
					else
							echo "[II] $zeile was correctly installed" >> $logfile
					fi
			else
					echo $zeile + " packages are being loaded"
			fi
	done < $folder/$1
fi

#check the status of the installation and print a message when an error occured
if [ $success ]
then
        echo "... installation finished successful"
		echo "cleaning up the installation"
		sleep 2
        sudo pacman -R yaourt package-query yajl
        rm -r /tmp/{yaourt,package-query}
		echo "installation cleaned up"
else
		echo "... installation finished with error(s)"
		echo "please check the log file for more information"
fi
### END OF INSTALLATION PROCESS ###
