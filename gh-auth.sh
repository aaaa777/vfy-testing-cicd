#!/bin/bash

function parse_yaml () {
    local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
    sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
    awk -F$fs '{
        indent = length($1)/2;
        vname[indent] = $2;
        for (i in vname) {if (i > indent) {delete vname[i]}}
        if (length($3) > 0) {
        vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
            key=vn $2; if (key == "__user") {
                print($3)
                # return 0
            }
            # printf("%s%s=\"%s\"\n", vn, $2, $3);
        }
   }'
   return 0
}

gh auth login
GH_USER_NAME=$(parse_yaml ~/.config/gh/hosts.yml || echo "")

if [ -n $GH_USER_NAME ]; then
    git config --global user.name  "$GH_USER_NAME"
    git config --global user.email "$GH_USER_NAME@users.noreply.github.com"
fi