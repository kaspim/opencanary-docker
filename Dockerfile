FROM python:3.7-bullseye

RUN apt-get update \
    && apt-get install -y \
    libpcap-dev \
    curl \
    bash

RUN python3 -m pip install --upgrade pip \
    && pip3 install rdpy scapy pcapy opencanary \
    && opencanaryd --copyconfig \
    && mkdir -p /var/log/opencanary \
    && touch /var/log/opencanary/opencanary.log

COPY /etc/opencanaryd/opencanary.conf /etc/opencanary/opencanary.conf

ENTRYPOINT opencanaryd --start && tail -f -n 0 /var/log/opencanary/opencanary.log
