FROM ruby:2.5.1-slim

RUN apt-get clean \
    && apt-get update \
    && apt-get install -y -q \
      build-essential \
      chrpath \
      libssl-dev \
      libxft-dev \
      libfreetype6 \
      libfreetype6-dev \
      libfontconfig1 \
      libfontconfig1-dev \
      wget \
      nodejs \
      git

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN mv phantomjs-2.1.1-linux-x86_64 /usr/local/share && ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin

ENV CHROME_VERSION "google-chrome-stable"
RUN sed -i -- 's&deb http://deb.debian.org/debian jessie-updates main&#deb http://deb.debian.org/debian jessie-updates main&g' /etc/apt/sources.list \
  && apt-get update && apt-get install wget -y
ENV CHROME_VERSION "google-chrome-stable"
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list \
  && apt-get update && apt-get -qqy install ${CHROME_VERSION:-google-chrome-stable}
CMD /bin/bash

RUN mkdir -p /app \
             /rubygems

# Set the base working directory as /app
WORKDIR /app

# Ensure persistence of gems
ENV GEM_HOME /rubygems
ENV BUNDLE_PATH /rubygems

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

# Add the services to the workdir
ADD . /app
