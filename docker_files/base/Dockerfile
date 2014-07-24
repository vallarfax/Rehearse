FROM ubuntu
MAINTAINER Chris McCollister

# Base Selenium setup. Would like to abstract this to its own Docker image
RUN apt-get update && apt-get install -y \
	openjdk-7-jre

ADD selenium-server-standalone.jar /
