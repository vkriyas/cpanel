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

home_base="/"$(echo $HOME | cut -d/ -f 2)

sudo grep -q $DOMAIN /etc/trueuserdomains
if [ $? -eq 0 ]; then
        home_dir=$home_base/$USERNAME/public_html
else

        if sudo [ -d $home_base/$USERNAME/$DOMAIN ] ; then
                home_dir=$home_base/$USERNAME/$DOMAIN
        fi

        if sudo [ -d $home_base/$USERNAME/public_html/$DOMAIN ] ; then
                home_dir=$home_base/$USERNAME/public_html/$DOMAIN
        fi
fi

if ! sudo [ -d $home_dir ]; then
        echo "Unable to find domain root"
        exit 1
fi

sudo mv $home_dir/.htaccess $home_dir/.htaccess.orig.$$ > /dev/null 2>&1

cat <<EOF | sudo tee $home_dir/.htaccess > /dev/null
Order deny,allow
Deny from all
EOF

echo "Done"
exit 0
