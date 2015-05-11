#!/bin/bash

set -o nounset

DISTRO_NAME="ubuntu"
DISTRO_VERSION="14.04"
BASE_DIR=$HOME/.snowbox

random_string()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}



set_distro_name()
{
    name=$(head -1 /etc/issue | awk '{print $1}')
    DISTRO_NAME=$(echo "${name,,}")

    ## centos 7
    if [ "$DISTRO_NAME" == "ubuntu" ]; then
        DISTRO_VERSION=$(head -1 /etc/issue | awk '{print $2}' | awk -F"." '{print $1"."$2}')
    elif [ "$DISTRO_NAME" == "centos" ] || [ "$DISTRO_NAME" == "debian" ]; then
        DISTRO_VERSION=$(head -1 /etc/issue | awk '{print $3}')
    else 
        DISTRO_VERSION=""
    fi

}


gen_dockerfile()
{
    mkdir -p $BASE_DIR
    suffix=$(random_string)
    dockerfile=$BASE_DIR/Dockerfile_$suffix
    
    ## FROM 
    echo -n "FROM $DISTRO_NAME" >> $dockerfile
    if [ "$DISTRO_VERSION" != "" ];then
        echo  ":$DISTRO_VERSION" >> $dockerfile
    else 
        echo -e "\n" >> $dockerfile
    fi

    ## MAINTAINER
    echo "MAINTAINER SnoxBox" >> $dockerfile

    ## use mirrors in china
    if [ "$DISTRO_NAME" == "ubuntu" ]; then
        echo "RUN sed -i \"s/archive.ubuntu.com/mirrors.ustc.edu.cn/\" /etc/apt/sources.list" >> $dockerfile
    fi

    ## refresh repos
    if [ "$DISTRO_NAME" == "ubuntu" ]; then
        echo "RUN apt-get update" >> $dockerfile
    fi


    ## real action
    echo "RUN $2" >> $dockerfile

    docker build -f $dockerfile -t $1 $BASE_DIR 

}

usage()
{
    echo "hehe"
}

main()
{
    if [ $# -ne 1 ]; then
        usage
    fi

    set_distro_name 

    gen_dockerfile "$@"
}

main "$@"