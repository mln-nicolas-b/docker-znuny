FROM ruby:alpine AS builder

ARG ZNUNY_VERSION=6.3.4

RUN gem install bashly

COPY ./znuny/${ZNUNY_VERSION}/ /tmp

WORKDIR /tmp/

RUN bashly generate --env production

FROM debian:stable-slim

LABEL org.opencontainers.image.source = "https://github.com/FR-BEZ-AOSC/docker-znuny"

ARG ZNUNY_VERSION=6.3.4
ARG ZNUNY_CHECKSUM=7b9736b22dbcf87e1f5d96f7a9beecd5

WORKDIR /opt/otrs

RUN apt-get update && apt-get install -y \
  wget \
  curl \
  jq \
  apache2 \
  openssl \
  cron \
  locales \
  cpanminus \
  postgresql-client \
  libapache2-mod-perl2 \
  libtimedate-perl \
  libnet-dns-perl \
  libnet-ldap-perl \
  libio-socket-ssl-perl \
  libpdf-api2-perl \
  libsoap-lite-perl \
  libtext-csv-xs-perl \
  libjson-xs-perl \
  libapache-dbi-perl \
  libxml-libxml-perl \
  libxml-libxslt-perl \
  libyaml-perl \
  libarchive-zip-perl \
  libcrypt-eksblowfish-perl \
  libencode-hanextra-perl \
  libmail-imapclient-perl \
  libtemplate-perl \
  libdatetime-perl \
  libmoo-perl \
  bash-completion \
  libyaml-libyaml-perl \
  libjavascript-minifier-xs-perl \
  libcss-minifier-xs-perl \
  libauthen-sasl-perl \
  libauthen-ntlm-perl \
  libhash-merge-perl \
  libical-parser-perl \
  libspreadsheet-xlsx-perl \
  libdata-uuid-perl \
  libdbd-odbc-perl \
  libdbd-pg-perl \
  libcpan-audit-perl \
  libcrypt-jwt-perl \
  libcrypt-openssl-x509-perl \
  libexcel-writer-xlsx-perl \
  && apt-get clean all

RUN cpanm install Jq

COPY --from=builder /tmp/zcli /usr/bin/

RUN /usr/bin/zcli download -r ${ZNUNY_VERSION} -s ${ZNUNY_CHECKSUM}

EXPOSE 80

ENTRYPOINT [ "zcli", "init" ]
