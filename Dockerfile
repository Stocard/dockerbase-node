FROM node:5.7.0

# Add Tini
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

ENV HOME /root
WORKDIR /root

RUN apt-get update \
&& apt-get upgrade -y --no-install-recommends \
&& apt-get install -y software-properties-common \
&& apt-get install -y curl git htop unzip vim wget \

# Increase limits
RUN touch /etc/security/limits.d/my.conf \
&& echo '* hard nofile 16384' >> /etc/security/limits.d/my.conf \
&& echo '* soft nofile 16384' >> /etc/security/limits.d/my.conf \

&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

