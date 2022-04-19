#!/bin/bash

version="v1.1"

echo "Build Dockerfile.docker.master.course docker_master_course:${version}"
exists=$(docker images --no-trunc docker_master_course:${version} | cut -w -f2 | tail -n1)
if [ "${exists}x" != "TAGx" -a "${exists}x" = "${version}x" ]
then
  docker rmi docker_master_course:${version}
fi
docker build --build-arg USER_ARG="docker" \
  --build-arg GO_PATH_PREFIX_ARG="/opt" \
  --build-arg PORT_ARG="8080" \
  --file Dockerfile.docker.master.course \
  --tag docker_master_course:${version} .
read -n 1 -s -r -p "Press any key to continue"
