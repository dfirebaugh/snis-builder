FROM debian:latest

ARG VERSION=1.0.0-latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    dpkg-dev \
    fakeroot \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /deb-build

RUN mkdir -p deb-root/usr/bin \
             deb-root/usr/libexec/snis/bin \
             deb-root/usr/libexec/snis/share \
             deb-root/usr/share/applications \
             deb-root/usr/share/doc/snis \
             deb-root/DEBIAN

COPY ./output/$VERSION/bin deb-root/usr/libexec/snis/bin/
COPY ./output/$VERSION/share deb-root/usr/libexec/snis/share/


COPY ./deployments/deb/control deb-root/DEBIAN/control
COPY ./deployments/deb/postinst deb-root/DEBIAN/postinst
COPY ./deployments/deb/prerm deb-root/DEBIAN/prerm
RUN chmod 755 deb-root/DEBIAN/postinst deb-root/DEBIAN/prerm

RUN sed -i "s/__VERSION__/$VERSION/g" deb-root/DEBIAN/control

RUN dpkg-deb --build deb-root "snis_${VERSION}_amd64.deb"

CMD ["/bin/bash", "-c", "cp /deb-build/snis_${VERSION}_amd64.deb /release/"]

