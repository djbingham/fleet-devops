#! /bin/bash

# Docker registry data volumes.
docker run \
    --name "registry-data" \
    -v /var/lib/registry \
    --volumes-from "proxy-data" \
    --entrypoint /bin/true \
    registry:2
