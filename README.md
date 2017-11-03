# Docker Container IPMI Viewer

This Docker container is used to access Supermicro IPMI consoles which require JDK to work. It's built on Debian Jessie and weighs in at around 650mB, so it's not very light.
It's built for convenience as using the JDK for some IPMI consoles was really unstable.

* Debian Jessie +
* openjdk-8
* icedtea
* firefox
* x11 server
* fluxbox
* noVNC

Includes a script to generate the the IPMI JNLP file.


## Building Container
```
docker build . -t ipmi-viewer
```
## Run
```
docker run -p 8080:8080 ipmi-viewer
```
Browse to 127.0.0.1:8080

## Run and generate JNLP file for quicker IPMI access - username is optional, defaults to ADMIN
docker run -p 8080:8080 ipmi-viewer

### Or all in one, run and then generate JNLP...
```
ID=$(docker run -d -p 8080:8080 ipmi-viewer) \
; sleep 5 \
; docker exec $ID /root/jnlp.py --host http://xyz --password SECRET --user ADMIN \
&& open http://127.0.0.1:8080
```
