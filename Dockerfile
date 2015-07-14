FROM ubuntu:14.04
MAINTAINER Jeffrey Horn "jeffh@generalassemb.ly"

# install ircd
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
# prevent ircd from starting immediately
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d
RUN apt-get update && apt-get install -y ircd-irc2

# configure ircd
ADD ircd.conf /etc/ircd
ADD ircd.motd /etc/ircd
RUN chown -R irc:irc /etc/ircd

# cleanup
RUN rm /usr/sbin/policy-rc.d

USER irc
EXPOSE 6667

ADD start /usr/local/bin/start
CMD ["/usr/local/bin/start"]
