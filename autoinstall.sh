#!/bin/bash

#author: troopa der pate
#date: 2012-10-18
#desc: simple script to download packages from a list. works only on ArchLinux

folder=$(pwd)
failed=false
#install yaourt so all programms can be installed either from AUR
cd /tmp
wget http://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
tar -xzf package-query.tar.gz
wget http://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
tar -xzf yaourt.tar.gz
if test -d /tmp/package-query
then
	cd package-query/
	sudo pacman -S yajl --noconfirm
	makepkg
	sudo pacman -U *.xz --noconfirm
else
	echo "/tmp/package-query could not be created"
fi

if test -d /tmp/yaourt
then
	cd /tmp/yaourt/
	makepkg
	sudo pacman -U *.xz --noconfirm 
else
	echo "/tmp/yaourt could not be created"
fi

#intall all packages with yaourt
while read zeile
do
set $zeile
	beginning= $(echo $zeile | egrep ^#)
	if [ beginning ]
	then
		yaourt -S $zeile --noconfirm
		if test $zeile -ne 0 
		then
			echo "$zeile was not installed correctly"
			failed=true;
		else
			echo "$zeile was correctly installed"
		fi
	else
		echo "\n"
	fi
done < $folder/$1

#check the status of the installation and print a message when an error occured
if [ $failed ]
then
	echo "the installation ends in an error, please see the output for further information"
else
	echo "clean up the installation"
	sudo pacman -R yaourt package-query yajl
	#rm -r /tmp/{yaourt,package-query}
fi

