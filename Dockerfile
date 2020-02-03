FROM i386/alpine:3.10

ENV PUID=1000
ENV PGID=1000

RUN \
    apk update && \
    apk add --no-cache \
    nodejs \
    npm \
    yarn \
    wget \
    git \
    unzip \
    jq && \
    mkdir /deez && \
    rm -R /config && \
    ln -sf /deez/.config/Deezloader\ Remix/ /config && \
    ln -sf /downloads /deez/Deezloader\ Music

RUN \
    wget https://notabug.org/RemixDevs/DeezloaderRemix/archive/master.zip && \
    unzip master.zip && \
    rm master.zip

WORKDIR /deezloaderremix

RUN \
    yarn install && \
    yarn cache clean
  
EXPOSE 1730

COPY root/ /

VOLUME /downloads /config
