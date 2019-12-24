#!/usr/bin/env bash

openssl req -x509 -nodes -sha256 -nodes -newkey rsa:2048 \
  -sha256 \
  -config openssl.cnf \
  -days 3650  \
  -keyout mnsca.key  \
  -out mnsca.crt \
  -subj '/C=US/ST=South Carolina/L=Columbia/O=Muscle & Strength, LLC/OU=Secure Services/CN=Muscle & Strength CA/emailAddress=webmaster@muscleandstrength.com'
