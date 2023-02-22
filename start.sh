#!/bin/bash
git clone https://github.com/aaaa777/connect-prj.git
if [ -z "$TUNNEL_NAME" ]; then
  TUNNEL_NAME="test-e$(cat /dev/urandom | base64 | fold -w 10 | head -n 1)"
fi

vscode-server rename  --accept-server-license-terms --name $TUNNEL_NAME && \
vscode-server --accept-server-license-terms
