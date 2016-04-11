#! /usr/bin/bash

# This file should export all environment variables required for any tasks to be performed.

# Set defaults for optional named arguments
DOMAIN="davidjbingham.co.uk"
LETSENCRYPT_EMAIL="letsencrypt@davidjbingham.co.uk"

# Override defaults for any optional arguments provided
[[ "${NAMED_ARGUMENTS['domain']}" == "" ]] || DOMAIN=${NAMED_ARGUMENTS['domain']}
[[ "${NAMED_ARGUMENTS['letsEncryptEmail']}" == "" ]] || LETSENCRYPT_EMAIL=${NAMED_ARGUMENTS['letsEncryptEmail']}

# Set sub-domains for projects to run under
export GOGS_DOMAIN="git.$DOMAIN"
export JENKINS_DOMAIN="ci.$DOMAIN"
export REGISTRY_DOMAIN="docker.$DOMAIN"
export TORAN_DOMAIN="toran.$DOMAIN"

export LETSENCRYPT_EMAIL
