FROM ubuntu:14.04

RUN apt-get update && apt-get install -y --force-yes --no-install-recommends\
 build-essential\
 ca-certificates\
 git\
 libjpeg8 \
 python-dateutil\
 python-imaging\
 python-ldap\
 python-libxslt1\
 python-lxml\
 python-openid\
 python-pil\
 python-psycopg2\
 python-psutil\
 python-pychart\
 python-reportlab\
 python-simplejson\
 python-virtualenv\
 python-yaml\
 python\
 tcllib\
 unzip\
 wget\
 zlib1g-dev

WORKDIR /opt/main
COPY .  /opt/main

RUN virtualenv --system-site-packages venv && . venv/bin/activate &&\
 pip install -r requirements.txt &&\
 patch -p1 < server.diff

ENTRYPOINT ["/opt/main/entrypoint.sh", "-c", "conf/openerp-server.conf"]
