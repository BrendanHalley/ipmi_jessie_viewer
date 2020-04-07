# Docker Container IPMI Viewer

This docker image is made to access Supermicro IPMI interfaces.

### Building Container
```
docker build . -t ipmi-viewer
```

### Run
```
docker run -p 8080:8080 ipmi-viewer
```

Then on the host machine browse to http://localhost:8080


#### Credits

Heavy influence has been taken from https://github.com/E46-S54/ipmi_jessie_viewer, I've changed some things to make it work better and fit my best practices.
