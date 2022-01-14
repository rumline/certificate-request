#!/bin/bash
openssl req -x509 -nodes -sha512 -newkey rsa:4096 -keyout `hostname -s`.key -out `hostname -s`.crt -config cert.conf -days 365
