FROM ubuntu:20.04

MAINTAINER Janaka Wickramasinghe <janaka@ascesnionit.com.au>

RUN apt-get update && apt-get install -y gnupg

COPY ./cloudarchive-xena.list /etc/apt/sources.list.d/cloudarchive-xena.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5EDB1B62EC4926EA 

RUN apt-get update && \
	DEBIAN_FRONTEND="noninteractive" apt-get install -y openstack-dashboard

RUN rm -rf /var/lib/apt/lists/*

VOLUME ["/var/www", "/var/log/apache2", "/etc/apache2",  \
	"/etc/openstack-dashboard", "/var/lib/openstack-dashboard", \
	"/usr/lib/python3/dist-packages/openstack_dashboard", \
	"/usr/share/openstack-dashboard"]

EXPOSE 80 443

ENTRYPOINT ["sh", "-c", "source /etc/apache2/envvars && /usr/sbin/apache2ctl -DFOREGROUND"]
