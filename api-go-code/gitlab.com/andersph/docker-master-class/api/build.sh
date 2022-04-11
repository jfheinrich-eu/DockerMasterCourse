#!/bin/bash

version="v1.1"

echo "Build Dockerfile api_golang:${version}"
exists=$(docker images --no-trunc api_golang:${version} | cut -w -f2 | tail -n1)
if [ "${exists}x" != "TAGx" -a "${exists}x" = "${version}x" ]
then
  docker rmi api_golang:${version}
fi
docker build --tag api_golang:${version} .
read -n 1 -s -r -p "Press any key to continue"

echo "Build Dockerfile.debian.base api_debain_base:${version}"
exists=$(docker images --no-trunc api_debian_base:${version} | cut -w -f2 | tail -n1)
if [ "${exists}x" != "TAGx" -a "${exists}x" = "${version}x" ]
then
  docker rmi api_debian_base:${version}
fi
docker build --file Dockerfile.debian.base \
  --tag api_debian_base:${version} .
read -n 1 -s -r -p "Press any key to continue"

echo "Build Dockerfile.debian.base.args api_debian_base_args:${version}"
exists=$(docker images --no-trunc api_debian_base_args:${version} | cut -w -f2 | tail -n1)
if [ "${exists}x" != "TAGx" -a "${exists}x" = "${version}x" ]
then
  docker rmi api_debian_base_args:${version}
fi
docker build --build-arg USER_ARG="joerg" \
  --build-arg GO_PATH_PREFIX_ARG="/opt" \
  --build-arg PORT_ARG="8989" \
  --file Dockerfile.debian.base.args \
  --tag api_debian_base_args:${version} .
read -n 1 -s -r -p "Press any key to continue"

echo "Build Dockerfile.debian.base.cmd.args api_debian_base_cmd_args:${version}"
exists=$(docker images --no-trunc api_debian_base_cmd_args:${version} | cut -w -f2 | tail -n1)
if [ "${exists}x" != "TAGx" -a "${exists}x" = "${version}x" ]
then
  docker rmi api_debian_base_cmd_args:${version}
fi
docker build --file Dockerfile.debian.base.cmd.args \
  --tag api_debian_base_cmd_args:${version} .
read -n 1 -s -r -p "Press any key to continue"
