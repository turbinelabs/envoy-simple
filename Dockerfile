FROM envoyproxy/envoy:9c273391b532dc20e7300dd2306782494947aa57

FROM turbinelabs/envtemplate:0.18.0

FROM phusion/baseimage:0.10.0

# upgrade/install deps
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get upgrade -y

# install envoy binary
COPY --from=0 /usr/local/bin/envoy /usr/local/bin/envoy

# install envtemplate
COPY --from=1 /usr/local/bin/envtemplate /usr/local/bin/envtemplate

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
