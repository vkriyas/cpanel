#!/bin/bash
USER=$1
TICKET=$2
sudo /app/bin/suspension-backend.sh -u $USER -s addon -l hacked -e "Please refer ticket $TICKET or contact support." -m
sudo /app/bin/suspension-backend.sh -u $USER -s http -l hacked -e "Please refer ticket $TICKET or contact support." -m
