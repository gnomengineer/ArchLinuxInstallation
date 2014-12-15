#!/bin/bash
folder=$(pwd)
echo -e "\ninstalling vundle from github..."

if test -d ~/.vim/bundle
then
    echo "directory already exists. continue to install vundle..."
else
    echo "creating directory ~/.vim/bundle..."
    mkdir ~/.vim/bundle
fi

cd ~/.vim/bundle/
echo "cloning vundle from github..."
#git clone https://github.com/gmarik/Vundle.vim.git
echo -e "\n______ FINISHED ________\n"
echo "Vundle is installed now. Check your ~/.vim/bundle directory for a Vundle.vim folder"
echo -e "use :PluginInstall within vim to install plugins \n"
cd $folder
