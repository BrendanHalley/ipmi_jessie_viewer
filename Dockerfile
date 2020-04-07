FROM openjdk:7u151-jdk-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install software-properties-common xvfb x11vnc wget supervisor fluxbox firefox-esr icedtea-7-plugin icedtea-netx net-tools

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD deployment.config /etc/.java/deployment/deployment.config

RUN mkdir -p /opt/noVNC/utils/websockify

RUN wget https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz -O noVNC.tar.gz \
  && wget https://github.com/novnc/websockify/archive/v0.9.0.tar.gz -O websockify.tar.gz \
	&& tar -xzf noVNC.tar.gz -C /opt/noVNC --strip 1 \
	&& tar -xzf websockify.tar.gz -C /opt/noVNC/utils/websockify --strip 1 \
	&& rm -f noVNC.tar.gz websockify.tar.gz

RUN sed -i 's/jdk.jar.disabledAlgorithms=MD2, MD5, RSA keySize < 1024/jdk.jar.disabledAlgorithms=MD2, RSA keySize < 1024/g' /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security

RUN ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html
RUN ln -s /opt/noVNC/images/favicon.ico /opt/noVNC/favicon.ico

RUN apt-get autoclean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

ENV DISPLAY :0
EXPOSE 8080
CMD ["/usr/bin/supervisord"]
