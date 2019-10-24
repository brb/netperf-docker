FROM alpine
MAINTAINER m@lambda.lt

ADD super_netperf /sbin/

RUN \
	apk add --update curl build-base bash git automake autoconf texinfo && \
    git clone https://github.com/brb/netperf && \
    cd netperf && \
    ./autogen.sh && \
	./configure --prefix=/usr && make && make install && \
	rm -f /usr/share/info/netperf.info && \
	strip -s /usr/bin/netperf /usr/bin/netserver && \
	apk del build-base && rm -rf /var/cache/apk/*

CMD ["/usr/bin/netserver", "-D"]
