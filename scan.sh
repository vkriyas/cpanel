#!/bin/bash

DOMAIN=$1

if [ "$1" == "" ]; then
        echo "ERROR: domain name must be specified"
        exit 1
fi

USERNAME=$(sudo /scripts/whoowns $DOMAIN)
echo "Username = $USERNAME"

if [ "$USERNAME" == "" ]; then
        echo "ERROR: Unable to find user from domain"
        exit 1
fi

EMAIL=$(sudo cat /var/cpanel/users/$USERNAME |grep CONTACTEMAIL= |cut -d= -f 2)
echo "EMAIL=$EMAIL"
OWNER=$(sudo cat /var/cpanel/users/$USERNAME |grep OWNER= |cut -d= -f 2)
echo "OWNER=$OWNER"
if [ "$OWNER" != "root" ]; then
  OWNER_EMAIL=$(sudo cat /var/cpanel/users/$OWNER |grep CONTACTEMAIL= |cut -d= -f 2)
  echo "OWNER_EMAIL=$OWNER_EMAIL"
  OWNER_DNS=$(sudo cat /var/cpanel/users/$OWNER |grep DNS1= |cut -d= -f 2)
  echo "OWNER_DNS=$OWNER_DNS"
fi

echo -e "\nscanning ...\n"

sudo /app/bin/hackscan.sh -q /home/$USERNAME

echo -e "\n\nDone\n"

exit 0
