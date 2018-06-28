FROM envoyproxy/envoy:9c273391b532dc20e7300dd2306782494947aa57

FROM phusion/baseimage:0.10.0

# upgrade/install deps
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get upgrade -y
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y git

# install envoy binary
COPY --from=0 /usr/local/bin/envoy /usr/local/bin/envoy

# install go
RUN curl -s -L -O https://storage.googleapis.com/golang/go1.10.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.10.1.linux-amd64.tar.gz
ENV GOPATH /go
ENV PATH "$PATH:/usr/local/go/bin:$GOPATH/bin"

# install envtemplate
RUN go get github.com/turbinelabs/envtemplate
RUN go install github.com/turbinelabs/envtemplate
RUN mv $GOPATH/bin/envtemplate /usr/local/bin/envtemplate

# cleanup go
RUN rm -rf /usr/local/go
RUN rm -rf $GOPATH

# cleanup git
RUN DEBIAN_FRONTEND="noninteractive" apt-get remove -y git
RUN DEBIAN_FRONTEND="noninteractive" apt-get autoremove -y

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add boostrap config file
ADD bootstrap.conf.tmpl /etc/envoy/bootstrap.conf.tmpl

# add start script
ADD start-envoy.sh /usr/local/bin/start-envoy.sh
RUN chmod +x /usr/local/bin/start-envoy.sh

# These are best guesses
EXPOSE 80 443 9999

# Use baseimage-docker's init system.
CMD ["/sbin/my_init", "--", "/usr/local/bin/start-envoy.sh"]
