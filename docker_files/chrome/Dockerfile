FROM vallarfax/selenium-browser-base
MAINTAINER Chris McCollister

# Add Google public key to apt
ADD chrome_signing_key.pub /
RUN apt-key add /chrome_signing_key.pub

# Add Google to the apt-get source list
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list

# Install Chrome
RUN apt-get update && apt-get install -y \
	google-chrome-stable

# Download and copy the latest ChromeDriver to /usr/local/bin
ADD chromedriver /usr/local/bin/

CMD ["/bin/bash", "/var/register.sh", "chrome"]
