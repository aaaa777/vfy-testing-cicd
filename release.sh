#!/bin/bash

docker build -t "vscode-server" docker/vscode-server/arm64
#cat docker/vscode-server/arm64 | docker build -t "vscode-server" -