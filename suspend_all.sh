#!/bin/bash
USER=$1
TICKET=$2

if [ "$USER" == "" ]; then
	echo "USER must be specified"
	exit 1
fi

if [ "$TICKET" == "" ]; then
        echo "TICKET must be specified"
        exit 1
fi

sudo /app/bin/suspension-backend.sh -u $USER -s all -l hacked -e "Please refer ticket # $TICKET or contact support." -m
