FROM node:{VERSION}-alpine

ENV HOME /root
WORKDIR /root


# install tini to properly handle zombie reaping & signal comm
RUN apk add --update --no-cache bash curl tini
ENTRYPOINT ["/sbin/tini", "--"]
