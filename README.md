# Fleet-DevOps

This project aims to automate deployment of a collection of open-source dev-ops software to a CoreOS cluster:

1. Git repository
2. Docker registry
3. Composer package repository
4. Jenkins
5. Reverse proxy (Nginx)
6. Auto-generation of reverse proxy configurations to forward domain request to the appropriate Docker containers
7. Auto-generation of SSL certificates for each domain configured for the reverse-proxy

Bash scripts are provided to start all of the above as a suite of Systemd units, orchestrated by Fleet.

Note that the `unit-resources` directory contains sample configuration files for each unit. Each of the files whose name begins `sample.` should be copied and pasted to the same location, with `sample.` removed from the file name. In each of the new configuration files, domains should be replaced with the domain from which each unit should expect to be accessed, and any security details (passwords, encryption keys, etc.) should be replaced with appropriate values unique to each installation.

## Execution

All tasks in this project should be executed via `run.sh`, in a manner such as:

`. run.sh {{command}} --host={{host}} --hostDir={{hostDir}} --domain={{domain}} --letsEncryptEmail={{letsEncryptEmail}}`

The order of arguments, including the command to run, is unimportant. The recognised arguments are as follows:

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
