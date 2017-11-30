FROM phusion/baseimage:latest

ENV HOME /root
WORKDIR /root

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 94AE36675C464D64BAFA68DD7434390BDBE9B9C5
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys FD3A5288F042B6850C66B31F09FE44734EB7990E
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 71DCFD284A79C3B38668286BC97EC7A07EDE3FC1
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys DD8F2338BAE7501E3DD5AC78C273792F7D83545D
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B9AE9905FFD7803F25714661B63B535A4C206CA9
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 56730D5401028683275BD23C23EFEFE93C4CFFFE
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 77984A986EBC2AA786BC0F66B01FBB92821C587A

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 8.9.1

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz"
RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" 
RUN gpg --verify SHASUMS256.txt.asc 
RUN grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - 
RUN tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 
RUN rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc


RUN apt-get update \
&& apt-get upgrade -y --no-install-recommends \
&& apt-get install -y software-properties-common \
&& apt-get install -y curl git htop unzip vim wget netcat

RUN npm i -g yarn

# Increase limits
RUN touch /etc/security/limits.d/my.conf \
&& echo '* hard nofile 16384' >> /etc/security/limits.d/my.conf \
&& echo '* soft nofile 16384' >> /etc/security/limits.d/my.conf \
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
