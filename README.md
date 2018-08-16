# dockerbase-node

Provides a base image to run node.js applications in: `stocard/node:X.Y`

You can try it out by: `docker run -it stocard/node:8.11 node`

It currently builds three different base images:

* newest minor semver of node 8
* node version 8.x
* node version 10.x

The size is ~26MB.

### More information

The base image is based on `node:x.x-alpine` (https://hub.docker.com/_/node/).

It also includes:

* `bash`
* `curl`

and has tini-init from https://github.com/krallin/tini
