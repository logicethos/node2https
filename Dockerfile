FROM nginx

RUN apt-get update \
    && apt-get -y install socat gettext wget openssl

RUN mkdir /data
COPY *.conf /data/
COPY ssl.sh /data/.


# Copy in entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

#configure Nginx
RUN rm /etc/nginx/conf.d/default.conf 
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf_bak
RUN sed '/^http.*/a include /data/*.conf;' /etc/nginx/nginx.conf_bak > /etc/nginx/nginx.conf
# Make a temp self-signed cert
RUN openssl req -new -x509 -days 365 -nodes \
  -out /etc/ssl/certs/nginx.crt \
  -keyout /etc/ssl/private/nginx.key \
  -subj "/C=UK/ST=UK/L=London/O=LE/CN=www.selfsert.com"


# Install letsencrypt SSL service
WORKDIR /root
RUN mkdir /root/.acme.sh
RUN wget https://raw.githubusercontent.com/Neilpang/acme.sh/master/acme.sh
RUN chmod +x acme.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80 443