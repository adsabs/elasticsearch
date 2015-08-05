#!/bin/bash
curator delete indices --older-than 31 --time-unit days --timestring %Y.%m.%d >> /tmp/curator.log
