#!/bin/bash
echo -e "\nstarting to copy configurations..."

if test -d system_config/
then
    echo "copying the configurations to the home folder"
    $(ls -A system_config/ > temp.txt)
    while read line
    do
        set $line
        cp -r system_config/$line ~/
    done < temp.txt
    ls -la ~/
    rm temp.txt
    echo -e "done.. system configuration copied!\n"
else
    echo "you're not in the correct order!"
    echo "go to the folder with the 'system_config' as subfolder"
    echo -e "aborting.. nothing copied!\n"
fi
