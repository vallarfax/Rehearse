# Selenium containers

This repo contains files to build and run docker containers for running a selenium hub and headless instances of Firefox and Chrome. A Vagrant configuration is also included which can be used as a build environment. Ansible is used to provision the VM with the latest version of Docker.


## Building the images

### Vagrant

If you'd like to build the images within Vagrant: 
	
	vagrant up
	vagrant ssh

Inside the VM run:

	cd /vagrant/docker_files
	./build.sh


### Build commands

Download necessary dependencies and build the containers:

	./build.sh


Stop and remove all running selenium containers and delete their images:
	
	./build.sh clean_images


Remove downloaded dependencies:

	./build.sh clean


## Running the containers

### Running the server

	sudo docker run -d -p 4444:4444 vallarfax/selenium-hub


### Running the clients

A Python script has been included to make starting and stopping containers a bit easier. To start containers for both Chrome and Firefox run:

	python browsers.py start --hub=HUB_IP_ADDRESS


More information about the script can be seen by running:

	python browsers.py --help
