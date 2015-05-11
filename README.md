# SnowBox
A sandbox for linux based on docker.

This script will build an image with the package you want to install,and then
you can run it within a container,then you can delete the container.No harm to your
host os at all.

## usage
`./box.sh <image name> <package install command>`

for example:

1. build

   `./box.sh firefox "apt-get install -y firefox"`

2. run

   `docker run -e DISPLAY --net=host firefox`


## Supported Distros

- centos
- ubuntu
- arch


## Notes

1. To run gui apps in container ,you need to run the command below first:

    `xhost +`
