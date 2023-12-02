FROM python:3.11-slim

WORKDIR /

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt update && apt-get install -y sudo nmap jq sqlite3 wget git curl jc && rm -rf /var/lib/apt/lists/*

RUN pip install shodan
##RUN shodan init Your_Shodan_API_Key

RUN git clone https://github.com/belane/CloudHunter.git /cloud_hunter
RUN pip install -r /cloud_hunter/requirements.txt

RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && chmod +x /usr/bin/yq

ADD source /workspace

