FROM vizzbuzz/base-alpine
ADD check.sh /bin/check.sh
CMD /bin/check.sh 
