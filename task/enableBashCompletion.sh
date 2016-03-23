#! /bin/bash

# Enable bash-completion for Docker and Docker-Compose on CoreOS

toolbox dnf update --verbose --assumeyes
toolbox dnf install --verbose --assumeyes bash-completion
toolbox curl --create-dirs -L https://raw.githubusercontent.com/docker/docker/v$(docker version -f '{{.Client.Version}}')/contrib/completion/bash/docker -o /usr/share/bash-completion/completions/docker
toolbox curl --create-dirs -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /usr/share/bash-completion/completions/docker-compose
toolbox cp /usr/share/bash-completion /media/root/var/ -R
source /var/bash-completion/bash_completion
echo 'source /var/bash-completion/bash_completion' >> /home/core/.bashrc
