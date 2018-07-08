FROM ubuntu:16.04
MAINTAINER mario123na mario@avalogics.com
RUN apt-get update
RUN apt-get -y install apache2 wget unzip net-tools
RUN apt-get -y upgrade
RUN wget https://github.com/BlackrockDigital/startbootstrap-freelancer/archive/gh-pages.zip
RUN unzip gh-pages.zip
RUN cp -ra startbootstrap-freelancer-gh-pages/* /var/www/html/
EXPOSE 80
CMD /usr/sbin/apache2ctl -D FOREGROUND
