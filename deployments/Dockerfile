FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    wget \
    build-essential \
    portaudio19-dev \
    libpng-dev \
    libvorbis-dev \
    libsdl2-dev \
    libsdl2-2.0-0 \
    liblua5.2-dev \
    libglew-dev \
    sox \
    libcrypt-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates

# the files we create on the host system should be owned by the user
# it's up to the caller of docker to pass in UID args
ARG USERNAME=snis
ARG UID=1000
ARG GID=1000
ARG VERSION=1.0.0-latest

RUN groupadd -g $GID $USERNAME && \
useradd -m -u $UID -g $GID -s /bin/bash $USERNAME

WORKDIR /usr/src
RUN git clone https://github.com/smcameron/space-nerds-in-space.git

WORKDIR /usr/src/space-nerds-in-space
RUN chown -R $UID:$GID /usr/src/space-nerds-in-space

USER $USERNAME
RUN make -j$(nproc) DOWNLOAD_OPUS=yes 2>&1 | tee /tmp/build.log
RUN make PREFIX=/usr/src/space-nerds-in-space/share ; make PREFIX=/usr/src/space-nerds-in-space/share install

CMD ["/bin/bash", "-c", "mkdir -p /output/$VERSION/usr/local/share/applications && cp -r bin/* /output/$VERSION/bin && cp -r share/* /output/$VERSION/share && cp /usr/src/space-nerds-in-space/share/applications/io.github.smcameron.space-nerds-in-space.desktop /output/$VERSION/usr/local/share/applications/ && cp /usr/src/space-nerds-in-space/share/applications/io.github.smcameron.space-nerds-in-space.svg /output/$VERSION/usr/local/share/applications/"]

