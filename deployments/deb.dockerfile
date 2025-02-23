FROM debian:latest

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

COPY ./output/bin deb-root/usr/libexec/snis/bin/
COPY ./output/share deb-root/usr/libexec/snis/share/


COPY ./deployments/deb/control deb-root/DEBIAN/control
COPY ./deployments/deb/postinst deb-root/DEBIAN/postinst
COPY ./deployments/deb/prerm deb-root/DEBIAN/prerm
RUN chmod 755 deb-root/DEBIAN/postinst deb-root/DEBIAN/prerm

RUN dpkg-deb --build deb-root snis_1.0.0_amd64.deb

CMD ["/bin/cp", "/deb-build/snis_1.0.0_amd64.deb", "/output/deb/"]

