#!/bin/bash

trap 'exit' ERR


SELENIUM_VERSION=2.41
SELENIUM_REVISION=0
SELENIUM_FILENAME=selenium-server-standalone-${SELENIUM_VERSION}.${SELENIUM_REVISION}.jar
SELENIUM_URL=http://selenium-release.storage.googleapis.com/${SELENIUM_VERSION}/${SELENIUM_FILENAME}


TARGETS=( "$@" )
if [ $# -eq 0 ]; then
	TARGETS=('base' 'hub' 'browser-base' 'firefox' 'chrome');
fi


clean() {
	rm docker_files/base/selenium-server-standalone.jar docker_files/chrome/chrome_signing_key.pub docker_files/chrome/chromedriver docker_files/chrome/chromedriver.zip
}


clean_images() {
	# Stop all selenium containers
	sudo docker ps --no-trunc | grep 'selenium' | awk '{print $1}' | sudo xargs --no-run-if-empty docker stop

	# Remove all stopped containers
	sudo docker ps -a -q --no-trunc | awk '{print $1}' | sudo xargs --no-run-if-empty docker rm

	# Remove all selenium images
	sudo docker images | grep 'selenium' | awk '{print $1}' | sudo xargs --no-run-if-empty docker rmi

	# Remove all untagged images
	sudo docker images | grep '<none>' | awk '{print $3}' | sudo xargs --no-run-if-empty docker rmi
}


download() {
	cd docker_files
	cd base
	if [ ! -e selenium-server-standalone.jar ]; then
		curl -o selenium-server-standalone.jar ${SELENIUM_URL}
	fi
	cd ..


	cd chrome
	if [ ! -e chrome_signing_key.pub ]; then
		curl -o chrome_signing_key.pub "https://dl-ssl.google.com/linux/linux_signing_key.pub"
	fi

	if [ ! -e chromedriver.zip ]; then
		CHROMEDRIVER_VERSION=$(wget -q -O - http://chromedriver.storage.googleapis.com/LATEST_RELEASE)
		curl -o chromedriver.zip http://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip
	fi
	if [ ! -e chromedriver ]; then
		unzip chromedriver.zip
	fi
	cd ..
	cd ..
}


build() {
	cd docker_files
	for d in "${TARGETS[@]}"; do
		(
			cd "${d}"
			sudo docker build -t vallarfax/selenium-${d} .
			cd ..
		)
	done
	cd ..
}


case "$1" in
	clean_all)
			clean_images
			clean
			exit 0
			;;
	clean_images)
			clean_images
			exit 0
			;;
	clean)
			clean
			exit 0
			;;
	download)
			download
			exit 0
			;;
	*)
			download
			build
			exit 0
			;;
esac
