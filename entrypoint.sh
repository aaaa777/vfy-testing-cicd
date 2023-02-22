#!/bin/bash

# set repo url

if [ -n "$1" ]; then
  REPO_URL=$1
fi

if [ -n "$REPO_URL" ]; then
  git clone $REPO_URL
fi


# set container id tunnel name

if [ -z "$TUNNEL_NAME" ]; then
  TUNNEL_NAME="container-$(echo $HOSTNAME | cut -c 1-10)"
fi

vscode-server rename --accept-server-license-terms --name $TUNNEL_NAME && \
vscode-server
