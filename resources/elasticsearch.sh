#!/bin/bash
/opt/governor/governor -c /opt/governor/govern.conf && /opt/elasticsearch/bin/elasticsearch --default.path.data=/var/lib/elasticsearch --default.path.conf=/etc/elasticsearch --default.path.logs=/var/log/elasticsearch

