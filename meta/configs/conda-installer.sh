#!/bin/bash

if ! [ -x "$(which conda)" ]
then
	echo -e "\nInstalling miniconda"
	scriptFile="$(mktemp)"
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O "$scriptFile"
	bash "$scriptFile" -b -p $HOME/miniconda
	rm -f "$scriptFile"
fi
