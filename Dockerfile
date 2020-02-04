FROM i386/alpine:3.10

ENV PUID=1000
ENV PGID=1000

ENV S6_OVERLAY_RELEASE v1.22.1.0
ENV TMP_BUILD_DIR /tmp/build

# Pull in the overlay binaries
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_RELEASE}/s6-overlay-nobin.tar.gz ${TMP_BUILD_DIR}/
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_RELEASE}/s6-overlay-nobin.tar.gz.sig ${TMP_BUILD_DIR}/

# Pull in the trust keys
COPY keys/trust.gpg ${TMP_BUILD_DIR}/

# Patch in source for testing sources...
# Update, install necessary packages, fixup permissions, delete junk
RUN apk add --update s6 s6-portable-utils && \
    apk add --virtual verify gnupg && \
    chmod 700 ${TMP_BUILD_DIR} && \
    cd ${TMP_BUILD_DIR} && \
    gpg --no-options --no-default-keyring --homedir ${TMP_BUILD_DIR} --keyring ./trust.gpg --no-auto-check-trustdb --trust-model always --verify s6-overlay-nobin.tar.gz.sig s6-overlay-nobin.tar.gz && \
    apk del verify && \
    tar -C / -xzf s6-overlay-nobin.tar.gz && \
    cd / && \
    rm -rf /var/cache/apk/* && \
    rm -rf ${TMP_BUILD_DIR}

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
    chown abc:abc /deez && \
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

ENTRYPOINT [ "/init" ]