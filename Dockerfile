FROM ubuntu:20.04

RUN apt-get -qq update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -qq install -y git python3 python3-pip \
    locales python3-lxml

RUN apk update

RUN apk add --no-cache \
    git \
    postgresql-libs \
    jpeg-dev \
    imagemagick

RUN apk add --no-cache --virtual .build-deps \
    git \
    gcc \
    g++ \
    musl-dev \
    postgresql-dev \
    libffi-dev \
    libwebp-dev \
    zlib-dev \
    imagemagick-dev \
    msttcorefonts-installer \
    fontconfig

RUN update-ms-fonts && \
    fc-cache -f

RUN mkdir /data

RUN chmod 777 /data

RUN pip install -r https://gitlab.com/HarukaNetwork/OSS/HarukaAya/-/raw/staging/requirements.txt

RUN apk del .build-deps

RUN git clone https://gitlab.com/HarukaNetwork/OSS/HarukaAya.git -b staging /data/HarukaAya

RUN pip3 install flask
RUN pip3 install flask_restful

COPY ./config.yml /data/HarukaAya

WORKDIR /data/HarukaAya

EXPOSE 8080
CMD ["bash", "start.sh"]
