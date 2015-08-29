# Dockerizing Elasticsearch:
# Dockerfile for building elasticsearch on an ubuntu machine
# Elasticsearch will listen on port 9200 for web traffic:

# OS to use
FROM phusion/baseimage

# Provisioning
## Install dependencies
RUN apt-get update && apt-get install -y openjdk-7-jdk python-pip wget git

## Download elasticsearch
RUN wget -qO- https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.4.5.tar.gz | tar xvz -C /opt/ && mv /opt/elasticsearch-1.4.5 /opt/elasticsearch

## Install curator for elasticsearch
RUN pip install elasticsearch-curator
COPY resources/runscript.py /runscript.py
COPY resources/cronjob.sh /cronjob.sh
RUN crontab /cronjob.sh

## Install Governor binary
RUN mkdir -p /opt/governor
RUN git clone git://github.com/adsabs/governor.git /opt/governor/
RUN git -C /opt/governor pull && git -C /opt/governor reset --hard fb9273bb20fa4748d05901ad075de5b137246d2e
ENV CONSUL_HOST consul.adsabs
ENV CONSUL_PORT 8500

# Configuration files
##
COPY resources/govern.conf /opt/governor/
COPY resources/elasticsearch.sh /etc/service/elasticsearch/run

# Define the entry point for docker<->logstash
## Elasticsearch HTTP and communication
EXPOSE 9200 9300

# Add an environment variable for the JVM heapsize
ENV ES_HEAP_SIZE 1g

# How the docker container is interacted with
##
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/sbin/my_init"]
