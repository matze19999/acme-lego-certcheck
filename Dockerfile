FROM debian:latest

COPY /rootfs /

RUN /usr/bin/apt update && \
    /usr/bin/apt install -y bash curl libc6 bc openssl bc ca-certificates

RUN cd /
RUN /usr/bin/curl -SsL "https://github.com/go-acme/lego/releases/download/v3.3.0/lego_v3.3.0_linux_amd64.tar.gz" | /bin/tar -xz -C /usr/local/bin lego

WORKDIR /

CMD /bin/bash "/run.sh" && /usr/bin/tail -f /dev/null