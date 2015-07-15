FROM vizzbuzz/base-alpine
RUN apk add curl ca-certificates nmap socat bash
COPY root /
RUN chmod 755 /bin/*.sh /scripts/fixes/*.sh /scripts/checks/*.sh
CMD /bin/check.sh 
