FROM ubuntu:14.04
MAINTAINER Jeffrey Horn "jeffh@generalassemb.ly"
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update

# install ircd
RUN apt-get install -y ircd-irc2

# configure ircd
RUN rm -v /etc/ircd/ircd.conf
ADD ircd.conf /etc/ircd

RUN rm -v /etc/ircd/ircd.motd
ADD ircd.motd /etc/ircd

RUN chown -R irc:irc /etc/ircd


USER irc
EXPOSE 6667
CMD service ircd-irc2 start
