FROM vallarfax/selenium-browser-base
MAINTAINER Chris McCollister

# Install Firefox
RUN apt-get update && apt-get install -y firefox

CMD ["/bin/bash", "/var/register.sh", "firefox"]
