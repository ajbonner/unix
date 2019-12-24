#!/usr/bin/env bash

openssl req -x509 -nodes -sha256 -nodes -newkey rsa:2048 \
	-config openssl.cnf \
	-days 3650 \
	-extensions subject_alt_name \
	-keyout mns.dev.key \
	-out mns.dev.crt  \
	-subj '/C=US/ST=South Carolina/L=Columbia/O=Muscle & Strength, LLC/OU=Secure Services/CN=mns.dev/emailAddress=webmaster@muscleandstrength.com'
sudo cp mns.dev.crt mns.dev.key /etc/nginx/snippets
sudo service nginx restart
