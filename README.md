# SnowBox
A sandbox for linux based on docker.

This script will build an image with the package you want to install,and then
you can run it in a container,then you can delete the container,no harm to your
host os.

## usage
`./box.sh <image name> <package install command>`

example:
1. build
   `./box.sh firefox "apt-get install -y firefox"`

2. run
   `docker run -e DISPLAY --net=host firefox`


## Supported Distros

- centos
- ubuntu
- arch

