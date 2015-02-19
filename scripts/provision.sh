#!/bin/bash

domain=$1

echo "I am provisioning $domain."
echo "127.0.0.1   $domain" >> /etc/hosts
echo "Added an entry to /etc/hosts"

sed -i "s/ServerName .*/ServerName $domain/" /etc/httpd/sites-available/springboard.conf
echo "Replaced the ServerName in the vhost"

service httpd restart
echo "Restarted apache"

echo "$domain" > /app/keys/sustainer.key
echo "Replaced sustainer key"

sed -i "s/http\:.*local/http\:\/\/$domain/" /etc/drush/aliases.drushrc.php
echo "Replaced drush alias."

sed -i "s/http\:.*local/http\:\/\/$domain/" /app/local.settings.php
echo "Replaced local drupal settings."

echo "All done."
