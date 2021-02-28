FROM python:buster

RUN apt-get update \
    && apt-get install -y \
        libpcap-dev \
        sudo \
        curl \
        bash

RUN python3 -m pip install --upgrade pip \
    && pip3 install rdpy scapy pcapy opencanary \
    && opencanaryd --copyconfig \
    && mkdir -p /var/log/opencanary

COPY ./data/root/.opencanary.conf /root/.opencanary.conf

ENTRYPOINT opencanaryd --start && tail -f -s 60 /dev/null