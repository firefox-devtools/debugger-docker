FROM ubuntu:trusty

# Install Firefox build dependencies.
# Packages are from https://dxr.mozilla.org/mozilla-central/source/python/mozboot/mozboot/debian.py
RUN sudo apt-get update -q \
 && sudo apt-get upgrade -qy \
 && sudo apt-get install -qy \
  autoconf2.13 \
  build-essential \
  ccache \
  python-dev \
  python-pip \
  python-setuptools \
  unzip \
  uuid \
  zip \
  libasound2-dev \
  libcurl4-openssl-dev \
  libdbus-1-dev \
  libdbus-glib-1-dev \
  libgconf2-dev \
  libgtk-3-dev \
  libgtk2.0-dev \
  libiw-dev \
  libnotify-dev \
  libpulse-dev \
  libx11-xcb-dev \
  libxt-dev \
  mesa-common-dev \
  python-dbus \
  xvfb \
  wget \
  yasm \
  git

RUN sudo pip install --upgrade mercurial

RUN wget -O bootstrap.py https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py && python bootstrap.py --no-interactive --application-choice=browser

RUN mkdir -p /root/.mozbuild

# RUN git clone --depth 1 https://github.com/mozilla/gecko-dev gecko
# RUN hg clone https://hg.mozilla.org/integration/mozilla-inbound gecko
RUN hg clone https://hg.mozilla.org/integration/autoland gecko

WORKDIR gecko

ADD .mozconfig ./.mozconfig
RUN sudo chmod +x .mozconfig
