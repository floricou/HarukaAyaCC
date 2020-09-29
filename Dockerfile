FROM registry.gitlab.com/harukanetwork/oss/harukaaya:dockerstation

RUN git clone https://gitlab.com/HarukaNetwork/OSS/HarukaAya.git -b staging /data/HarukaAya

RUN pip3 install flask
RUN pip3 install flask_restful

COPY ./config.yml /data/HarukaAya

WORKDIR /data/HarukaAya

EXPOSE 8080
CMD ["bash","start.sh"]
