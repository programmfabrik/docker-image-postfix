FROM alpine:latest

LABEL maintainer="DevOps <devops@fylr.io>"

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache --update postfix cyrus-sasl ca-certificates bash musl musl-utils

RUN rm -rf /var/cache/apk/* && \
    sed -i -e 's/inet_interfaces = localhost/inet_interfaces = all/g' /etc/postfix/main.cf

# delete old pid file
RUN rm -f /var/spool/postfix/pid/master.pid && mkdir -p /postfix/sasl

# mark used directories
VOLUME [ "/var/spool/postfix", "/etc/postfix" ]

EXPOSE 25

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "postfix", "start-fg" ]