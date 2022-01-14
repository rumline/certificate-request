#!/bin/bash
openssl genrsa -out ./`hostname -s`.key 4096
openssl req -new -key ./`hostname -s`.key -out ./`hostname -s`.csr -config ./cert.conf
