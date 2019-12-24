#!/usr/bin/env bash

openssl req -x509 -nodes -sha256 -nodes -newkey rsa:2048 \
  -sha256 \
  -config openssl.cnf \
  -days 3650  \
  -keyout mnsca.key  \
  -out mnsca.crt \
  -subj '/C=US/ST=South Carolina/L=Columbia/O=Muscle & Strength, LLC/OU=Secure Services/CN=Muscle & Strength CA/emailAddress=webmaster@muscleandstrength.com'

openssl req -nodes -newkey rsa:2048 \
  -keyout mns.dev.key \
  -out mns.dev.csr \
  -subj '/C=US/ST=South Carolina/L=Columbia/O=Muscle & Strength, LLC/OU=Secure Services/CN=mns.dev/emailAddress=webmaster@muscleandstrength.com'


openssl x509 -req -in mns.dev.csr \
  -CA mnsca.crt -CAkey mnsca.key -CAcreateserial \
  -out mns.dev.crt -days 1825 -sha256 -extfile mns.dev.ext
