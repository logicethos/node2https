# Register domain with letsencrypt.
# This requires ports 80 & 443 open.  Other options exist. See https://github.com/Neilpang/acme.sh
# use --test before going to production, or you will get rate limited

# DNS Method example - uses DNS script from https://github.com/Neilpang/acme.sh/tree/master/dnsapi
#   export LINODE_API_KEY="frezpV5Asbn3dpAVutwqerweqrqwrExsGCykkIlgaxqflsQEf"
#   wget https://raw.githubusercontent.com/Neilpang/acme.sh/master/dnsapi/dns_linode.sh -O /root/.acme.sh/dns_linode.sh
#   /root/acme.sh --issue --dns /root/dns_linode.sh --dnssleep 900 $DOMAIN_LIST --key-file /etc/ssl/private/nginx.key  --fullchain-file /etc/ssl/certs/nginx.crt

/root/acme.sh --issue --standalone --tls --listen-v6 $DOMAIN_LIST --key-file /etc/ssl/private/nginx.key  --fullchain-file /etc/ssl/certs/nginx.crt
