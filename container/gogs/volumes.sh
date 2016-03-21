#! /bin/bash

# Gogs data volume.
docker run \
    --name "gogs-data" \
    --entrypoint /bin/true \
    gogs/gogs
