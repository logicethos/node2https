#!/bin/bash


for f in /data/*.conf
do
  echo "found $f"
  domains=$(grep -oP '(?<=server_name\s).*(?=;)' $f)
  IFS=' ' read -r -a array <<< "$domains"
  for element in "${array[@]}" 
  do
    if [[ "-d $element" =~ "$DOMAIN_LIST" ]]; then  #Add if not a duplicate domain
        DOMAIN_LIST+="-d $element"        
    fi    
  done
  
done

if [ -z "$DOMAIN_LIST" ]; then
    echo "No host domains found."
    exit 1
else
    echo $DOMAIN_LIST
fi

if ! /usr/sbin/nginx -t ; then
    echo "Nginx Failed."
    exit 1
fi

if [ -f /data/ssl.sh ]; then
  export DOMAIN_LIST
  /bin/bash /data/ssl.sh
else 
  # Register DOMAIN with letsencrypt
  /root/acme.sh --issue --standalone --tls $DOMAIN_LIST --key-file /etc/ssl/private/nginx.key  --fullchain-file /etc/ssl/certs/nginx.crt
fi  

#Start nginx
/usr/sbin/nginx -g "daemon off;error_log /dev/stdout info;"
