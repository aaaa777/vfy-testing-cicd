#!/bin/bash

# set repo url
if [ -n "$1" ]; then
  REPO_URL=$1
fi

if [ -n "$REPO_URL" ]; then
  git clone $REPO_URL
fi

# set dotfiles
if [ -n "$DOTFILES_REPO_URL"]; then
  cd ~
  mkdir -p docker-vscode-dev-temporary-files && cd docker-vscode-dev-temporary-files
  git clone $DOTFILES_REPO_URL
  cp -p */* ..
  cd .. && rm -rf docker-vscode-dev-temporary-files
  . .bash_profile
  cd /workspace
fi

# set container id tunnel name
if [ -z "$TUNNEL_NAME" ]; then
  TUNNEL_NAME="container-$(echo $HOSTNAME | cut -c 1-10)"
fi

# set tunnel name
if [ ! -e "/root/.vscode-cli/code_tunnel.json" ]; then
  vscode-server rename --accept-server-license-terms --name $TUNNEL_NAME
fi

# launch
vscode-server
