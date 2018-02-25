# node2https

 - Provide secure certified SSL connections to your nodes. Templates for
 - Factom & Ethereum nodes Automated certificate generation from
 - https://letsencrypt.org/ and registration from https://github.com/Neilpang/acme.sh

**Prerequisites**
 A domain & DNS server/provider pointing to your host.

**Get started**

    git clone https://github.com/logicethos/node2https.git

Copy one or more Nginx template config files from the Template directory

    cp Template/factom.conf .

edit factom.conf and follow commented instructions

If you don't want to expose ports 80 and 443, then you need to edit the ssl.sh file and use an alternative method of verification.

**Buid**

    docker build -t node2https .

**Run**

With ports 80/443 port authentication ( + add all your proxy ports)

    docker run -d -p 80:80 -p 443:443 -p <proxy port>:<proxy port> --name node2https node2https
Without 80/443 port authentication ( + add all your proxy ports )

    docker run -d  -p <proxy port>:<proxy port> --name node2https node2https
