# Development Server

This repository is a collection of bash scripts for setting up a Docker-driven development server, with the following services:

1. Git repository
2. Docker registry
3. Reverse proxy (Nginx)
4. Auto-generation of reverse proxy configurations for each Docker container
5. Auto-generation and configuration of SSL certificates for each Docker container

## Execution

All tasks in this project should be executed via either `local.sh` or `remote.sh`.

`remote.sh` will execute scripts on a remote server. It expects the following arguments:

1. (required) The remote server URI (user@domain)
2. (required) The task to run (relative path to the script file, excluding the ".sh" extension)
3. (optional) The domain to use for virtual hosts and SSL certificates, if different from the remote server domain

`local.sh` will execute scripts on the local machine. It expects the following arguments:

1. (required) The task to run (relative path to the script file, excluding the ".sh" extension)
2. (required) The domain to use for virtual hosts and SSL certificates, if different from the remote server domain

## Examples

```
# Run containers on the davidjbingham.co.uk server
./remote.sh core@davidjbingham.co.uk task/run

# Run containers on the davidjbingham.co.uk server with hosts and certificates set for djhodgkinson.co.uk domains
./remote.sh core@davidjbingham.co.uk task/run djhodgkinson.co.uk
```

## Project Structure

The primary scripts, `local.sh` and `remote.sh`, depend on the rest of the files in this project to perform operations. It is not recommended to run any of the other scripts directly, as they may have dependencies on specific variables being set, which is managed by the primary scripts. The structure of the project files follows.

The `task` directory contains scripts which perform bulk actions for all containers managed by this project, usually by iterating through the equivalent scripts for each set of containers.

The `container` directory contains a folder per service from the list above. Each service requires one or more containers and volumes and each service directory contains scripts for managing those.

The `resource` directory contains configuration files and other resources required by one or more of the services.
