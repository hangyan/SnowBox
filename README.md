# SnowBox
A sandbox for linux based on docker.

This script will build an image with the package you want to install,and then
you can run it within a container and delete it.No harm to your
host os at all.

## usage
`./box.sh <image name> <package install command>`

for example:

1. build

   `./box.sh firefox:v1 "apt-get install -y firefox"`

2. run

    `xhost +` (for gui app only)

    `docker run -e DISPLAY --net=host firefox:v1 firefox`


## Supported Distros

- centos
- ubuntu
- arch
- ...

## Notes
1. Package install command should be auto confirmed,mostly it's a `-y` flag
