ARG ZNUNY_VERSION=6.5.8
ARG ZNUNY_CHECKSUM=fef081777781edbaab923232e269b009

FROM ruby:alpine AS builder

ARG ZNUNY_VERSION

RUN gem install bashly

COPY ./znuny/${ZNUNY_VERSION}/ /tmp

WORKDIR /tmp/

RUN bashly generate --env production

FROM debian:stable-slim

ARG ZNUNY_VERSION
ARG ZNUNY_CHECKSUM

WORKDIR /opt/otrs

RUN apt-get update && apt-get install -y \
  wget \
  curl \
  jq \
  apache2 \
  openssl \
  cron \
  locales \
  gnupg2 \
  cpanminus \
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
  libcrypt-smime-perl \
  && apt-get clean all

RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg \
  && sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
  && apt update \
  && apt install -y postgresql-client-16 \
  && apt-get clean all

RUN cpanm install Jq

COPY --from=builder /tmp/zcli /usr/bin/

RUN /usr/bin/zcli download -r ${ZNUNY_VERSION} -s ${ZNUNY_CHECKSUM} \
      && zcli config locales

EXPOSE 80

ENTRYPOINT [ "zcli", "init", "all" ]
