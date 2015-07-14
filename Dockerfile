FROM vizzbuzz/base-alpine
RUN apk add curl ca-certificates nmap socat
COPY check.sh /bin/check.sh
RUN chmod 755 /bin/check.sh
CMD /bin/check.sh 
