FROM alpine:3.4

RUN apk update

RUN apk python3-pip

RUN apk add --no-cache \
    git \
    tzdata \
    python3 \
    postgresql-libs \
    jpeg-dev \
    imagemagick \
    bash

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
CMD ["bash","start.sh"]
