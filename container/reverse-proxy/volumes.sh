#! /bin/bash

# Volume for SSL certificates
docker run \
    --name "proxy-certificates" \
    -v /etc/nginx/certs \
    --entrypoint /bin/true \
    nginx

# Volumes for Nginx proxy
docker run \
    --name "proxy-data" \
    --volumes-from "proxy-certificates" \
    -v /etc/nginx/conf.d  \
    -v /etc/nginx/vhost.d \
    -v /usr/share/nginx/html \
	--entrypoint /bin/true \
    nginx
