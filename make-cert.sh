#!/bin/bash

set -e

mkdir certificates || true

openssl \
    req -x509 \
    -out certificates/$1.crt \
    -keyout certificates/$1.key \
    -newkey rsa:2048 \
    -nodes \
    -sha256 \
    -subj "/C=BR/ST=RS/O=Brave/CN=$1" \
    -extensions SAN \
    -extensions EXT \
    -config <( \
               printf "[dn]\nCN=$1\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:$1\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
