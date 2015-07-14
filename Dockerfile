FROM ubuntu:14.04
MAINTAINER Jeffrey Horn "jeffh@generalassemb.ly"

# work around policy
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

# install ircd
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update && apt-get install -y ircd-irc2

# configure ircd
RUN rm -v /etc/ircd/ircd.conf
ADD ircd.conf /etc/ircd

RUN rm -v /etc/ircd/ircd.motd
ADD ircd.motd /etc/ircd

RUN chown -R irc:irc /etc/ircd

# cleanup
RUN rm /usr/sbin/policy-rc.d

USER irc
EXPOSE 6667

ADD start /usr/local/bin/start
CMD ["/usr/local/bin/start"]
