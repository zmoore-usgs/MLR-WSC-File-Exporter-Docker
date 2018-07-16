#!/bin/ash
# shellcheck shell=dash

/usr/bin/gunicorn --reload app --config file:/local/gunicorn_config.py