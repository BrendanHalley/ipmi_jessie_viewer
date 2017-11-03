FROM openjdk:7u151-jdk-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install software-properties-common xvfb x11vnc wget supervisor fluxbox firefox-esr icedtea-7-plugin icedtea-netx net-tools git python-requests

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD deployment.config /etc/.java/deployment/deployment.config
ADD jnlp.py /root/jnlp.py

RUN git clone https://github.com/novnc/noVNC.git /root/noVNC \
	&& git clone https://github.com/novnc/websockify /root/noVNC/utils/websockify \
	&& rm -rf /root/noVNC/.git \
	&& rm -rf /root/noVNC/utils/websockify/.git

RUN ln -s /root/noVNC/vnc.html /root/noVNC/index.html
RUN ln -s /root/noVNC/images/favicon.ico /root/noVNC/favicon.ico

ENV DISPLAY :0
EXPOSE 8080
CMD ["/usr/bin/supervisord"]
