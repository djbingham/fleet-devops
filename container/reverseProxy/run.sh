#! /bin/bash

# Nginx proxy.
docker run \
	--name "proxy" \
	-d \
    --restart always \
	-p 80:80 \
    -p 443:443 \
    --volumes-from "proxy-data" \
    nginx

# Automated config generator for Nginx proxy.
docker run \
    --name "proxy-generator" \
    -d \
    --restart always \
    --volumes-from "proxy-data" \
    -v /home/core/resources/nginx.tmpl:/etc/docker-gen/templates/nginx.tmpl:ro \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    jwilder/docker-gen \
    -notify-sighup proxy -watch -only-exposed -wait 5s:30s /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default.conf

# Automated SSL certificate generation for proxied containers.
docker run \
	--name "proxy-encrypt" \
	-d \
    --restart always \
    -e NGINX_DOCKER_GEN_CONTAINER="proxy-generator" \
    --volumes-from "proxy-data" \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    jrcs/letsencrypt-nginx-proxy-companion
