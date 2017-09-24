ATOM_VERSION ?= v1.20.1
DEBIAN_MIRROR ?= deb.debian.org
all: docker-atom

docker-atom:
	wget -c https://github.com/atom/atom/releases/download/${ATOM_VERSION}/atom-amd64.deb -O ./atom-amd64-${ATOM_VERSION}.deb
	docker build --build-arg ATOM_PACKAGE=atom-amd64-${ATOM_VERSION}.deb --build-arg DEBIAN_MIRROR=$(DEBIAN_MIRROR) -t atom .
