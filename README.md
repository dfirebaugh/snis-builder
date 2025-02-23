# snis-builder

Build automation for [Space Nerds In Space](https://github.com/smcameron/space-nerds-in-space)

This could be extended to use in some kind of automated release pipeline.

it does the following:

* builds a docker image
* installs dependencies in the docker image
* clone the snis repo
* runs make to output snis binaries and assets
* copies binaries and assets out of docker image to host machine
* tarballs up the binaries into a release.tar

> to run this you need [docker installed](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
```bash
make # build the release
#   output dir contains binaries and assets
#   release dir contains the tarball
make clean # clean up
```

## on the target system

### Install from .deb

download the .deb file

```bash
sudo apt install ./snis_1.0.0_amd64.deb
```

run the game with 
```bash
snis
```

### Manual Install
download the tarball

You will still need to install the following dependencies.
```bash
apt install build-essential libsdl2-dev libglew-dev portaudio19-dev
```

extract the tarball

```bash
sudo mkdir -p /opt/snis
sudo chown $USER:$USER /opt/snis
tar -xvzf snis.tar.gz -C /opt/snis
```

update assets
```bash
cd /opt/snis/
./bin/update_assets_from_launcher.sh
```

> This copies assets to `~/.local/share/space-nerds-in-space/` dir.

launch the `snis_client`

```bash
/opt/snis/bin/snis_client
```

