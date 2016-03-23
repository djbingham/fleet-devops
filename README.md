# Development Server

This repository is a collection of bash scripts for setting up a Docker-driven development server, with the following services:

1. Git repository
2. Docker registry
3. Reverse proxy (Nginx)
4. Auto-generation of reverse proxy configurations for each Docker container
5. Auto-generation and configuration of SSL certificates for each Docker container

The `container` directory contains a folder per function from the list above. Each function requires one or more containers and volumes and each function's directory contains scripts for managing those.

The `task` directory contains scripts which perform bulk actions against all containers managed by this project, usually by iterating through the equivalent scripts for each set of containers.

The `resource` directory contains configuration files and other resources required by one or more of the containers.

The `remote.sh` script will execute any of the other scripts on a remote server. It expects two arguments:

1. The remote server URI (user@domain.tld)
2. The task to run (relative path to the script file, excluding the ".sh" extension)

```
# Remove all containers from server
HOST=core@davidjbingham.co.uk ./remote.sh task/purge

# Initialise all containers on server
HOST=core@davidjbingham.co.uk ./remote.sh task/run
```
