# elasticsearch

Docker images for elasticsearch

Configuration files are expected to sit on a Consul service, which is retrieved via the [Governor](https://github.com/adsabs/governor) package. The Consul service DNS and port are baked into the image for now as environment variables.

Basic usage:
  1. `docker build -t adsabs/elasticsearch .`
  1. `docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 --restart=always --log-driver syslog adsabs/logstash`
