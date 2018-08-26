#!/bin/bash


## Install apt stuff #####################################
sudo add-apt-repository ppa:webupd8team/java
sudo apt update
sudo apt install -y git vim-gtk zsh curl wget build-essential cmake oracle-java8-installer python-dev python3-dev apt-transport-https ca-certificates software-properties-common
#### Docker is weird.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo usermod -a -G docker $USER # Docker permission


## Install zsh ############################################
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


## Install python stuff ###################################
#### Check if pip exist
if [ ! -f $HOME/.local/bin/pip ]; then
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python get-pip.py --user
	python3 get-pip.py --user
	rm get-pip.py
elif [ -f $HOME/.local/bin/pip ]; then
	echo Pip already installed
fi
#### Install pip dependencies
pip3 install pipenv --user
pip3 install jedi --user
pip3 install flake8 --user
pip3 install autopep8 --user


## Install Android stuff ###################################
if [ ! -d $HOME/dev/tools ]; then
	mkdir -p $HOME/dev/tools
fi

if [ ! -d $HOME/dev/tools/android-studio ]; then
	for a in $( wget -qO-  http://developer.android.com/sdk/index.html | egrep -o "https:\/\/dl.google.com\/dl\/android\/studio\/ide-zips.*-linux\.zip" ); do
		wget $a && unzip android*.zip;
		sudo -v; 
		sudo mv android-studio $HOME/dev/tools; 
		sudo -v; 
		rm android*-linux.zip;
		break
	done
else
	echo Android Studio already installed to $HOME/dev/tools/android-studio. Skipping.
fi

if [ ! -f $HOME/.local/share/applications/android-studio.desktop ]; then
	echo Copying Android Studio desktop entry
	cp $(pwd)/android-studio.desktop $HOME/.local/share/applications/
fi

