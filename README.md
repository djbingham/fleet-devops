# Development Server

This repository is a collection of bash scripts for setting up a Docker-driven development server, with the following services:

1. Git repository
2. Docker registry
3. Reverse proxy (Nginx)
4. Auto-generation of reverse proxy configurations for each Docker container
5. Auto-generation and configuration of SSL certificates for each Docker container

## Execution

All tasks in this project should be executed via `run.sh`, in a manner such as:

`. run.sh {{command}} --host={{host}} --hostDir={{hostDir}} --domain={{domain}} --letsEncryptEmail={{letsEncryptEmail}}`

The order of arguments, including the command to run, is unimportant. The reognised arguments are as follows:

- `{{command}}` (required) Relative path to the script to be executed.
- `{{host}}` (optional) The remote server to execute the command on. Default: empty (will execute command locally)
- `{{hostDir}}` (optional) Directory into which files should be placed on the server (a subdirectory named `containers` will be created here). Default: `/home/core`
- `{{domain}}` (required) Domain to use for projects and SSL certificates
- `{{letsEncryptEmail}}` (optional) Email address to give to Let's Encrypt when requesting SSL certificates. Default: as per `config.sh`

## Examples

```
# Run all containers locally, for the domain davidjbinghamdev.co.uk
. run.sh compose/up --host=localhost --hostDir=/home/core --domain=davidjbinghamdev.co.uk --letsEncryptEmail=encrypt@davidjbingham.co.uk

# Run all containers on the davidjbingham.co.uk server
. run.sh compose/up --host=core@davidjbingham.co.uk --hostDir=/home/core --domain=davidjbingham.co.uk --letsEncryptEmail=encrypt@davidjbingham.co.uk
```

## Project Structure

The primary script, `run.sh`, depends on the rest of the files in this project to perform operations. It is not recommended to run any of the other scripts directly, as they may have dependencies on specific variables being set, which is managed by the primary scripts. The structure of the project files follows.

The `compose` directory contains scripts and and folders. Each folder contains `docker-compose.yml` and scripts for management of a set of containers for a single application. The scripts in the `compose` directory offer bulk management of all containers for all applications managed through this project.

The `environment` directory contains configuration files and installation scripts required to set-up a server to be managed by this project. It also includes resources used by the Vagrantfile to intialise a virtualised development environment for testing changes.
