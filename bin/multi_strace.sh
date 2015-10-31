#!/usr/bin/env bash

sudo strace $(pidof $1 |sed 's/\([0-9]*\)/\-p \1/g')
