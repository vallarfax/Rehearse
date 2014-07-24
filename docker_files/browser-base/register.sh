#!/bin/sh

BROWSER=$1

Xvfb :10 -screen 5 1024x768x8 -ac -extension &
export DISPLAY=:10.5
java -jar selenium-server-standalone.jar -role webdriver -hub http://${HUB_ADDRESS}:${HUB_PORT:=4444}/grid/register -browser browserName=${BROWSER}
