FROM debian:11

RUN mkdir -p /workspace && cd /workspace \
 && apt update \
 && apt install -y curl git wget nano \
                   nodejs npm
RUN npm install -g @vue/cli \
 && npm install -g @vue/cli-init \
 && npm install -g n \
 && npm install -g firebase-tools

RUN type -p curl >/dev/null || apt install curl -y \
 && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
 && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
 && apt update \
 && apt install gh -y

WORKDIR /workspace

#RUN wget -O- https://code-server.dev/install.sh │ sh \
#RUN curl -fsSL https://code-server.dev/install.sh | sh \
RUN wget https://aka.ms/vscode-server-launcher/aarch64-unknown-linux-gnu \
 && chmod +x aarch64-unknown-linux-gnu && mkdir -p /usr/local/lib/vscode-server \
 && mv aarch64-unknown-linux-gnu /usr/local/lib/vscode-server/ \
 && ln -s /usr/local/lib/vscode-server/aarch64-unknown-linux-gnu /usr/local/bin/vscode-server

COPY --chmod=755 start.sh /workspace/

CMD ["./start.sh"]
# && code-server \
#  --install-extension ms-python.python \
#  --install-extension ms-ceintl.vscode-language-pack-ja
