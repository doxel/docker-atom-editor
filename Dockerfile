FROM debian:stretch-slim

ARG ATOM_PACKAGE=atom-amd64-v1.20.1.deb
ARG DEBIAN_MIRROR=deb.debian.org
ARG USER=atom

COPY $ATOM_PACKAGE /tmp

RUN sed -r -i -e s/deb.debian.org/$DEBIAN_MIRROR/ /etc/apt/sources.list \
 && apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      fakeroot \
      gconf2 \
      gconf-service \
      git \
      gvfs-bin \
      libasound2 \
      libcap2 \
      libgconf-2-4 \
      libgtk2.0-0 \
      libnotify4 \
      libnss3 \
      libxkbfile1 \
      libxss1 \
      libxtst6 \
      libgl1-mesa-glx \
      libgl1-mesa-dri \
      python \
      wget \
      xdg-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt install /tmp/$ATOM_PACKAGE && \
    rm -f /tmp/$ATOM_PACKAGE && \
    useradd --create-home --shell /bin/bash $USER 

COPY .atom/ /home/$USER/.atom
RUN mkdir /home/$USER/src \
 && chown $USER:$USER /home/$USER -R

WORKDIR /home/$USER
USER $USER

CMD ["/usr/bin/atom","-f"]

