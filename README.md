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
