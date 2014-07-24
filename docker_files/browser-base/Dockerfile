FROM vallarfax/selenium-base
MAINTAINER Chris McCollister

# Install xvfb
RUN apt-get update && apt-get install -y xvfb

ADD register.sh /var/register.sh
RUN chmod 755 /var/register.sh
