FROM ubuntu

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common \
    unzip \
    vim \
    git \
    sudo \
    iputils-ping \
    curl \
    wget \
    xvfb \
    xauth \
    x11vnc \
    x11-utils \
    x11-xserver-utils  

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install \
  unzip \
  && \
  DL=https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && curl -sL "$DL" > /tmp/chrome.deb \
  && apt install --no-install-recommends --no-install-suggests -y \
    /tmp/chrome.deb

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt install nodejs -y

COPY . /root
WORKDIR /root
RUN npm install
# EXPOSE 5999
# ENV DISPLAY :99

ENTRYPOINT [ "./entrypoint.sh" ]

