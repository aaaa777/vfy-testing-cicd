FROM debian:11

RUN mkdir -p /workspace && cd /workspace \
 && apt update \
 && apt install -y curl git wget nano

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
