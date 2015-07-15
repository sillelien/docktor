FROM vizzbuzz/base-alpine
RUN apk add curl ca-certificates nmap socat bash docker python py-pip
RUN pip install tutum
RUN pip install awscli
COPY root /
RUN chmod 755 /bin/*.sh /scripts/fixes/*.sh /scripts/checks/*.sh
CMD /bin/check.sh 
