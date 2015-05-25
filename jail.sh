#!/bin/bash

DOCKER_CMD=docker
IMAGE_NAME=ubuntu:trusty
SHELL_CMD=/bin/bash

USER=$1
if [ "${USER}" == "" ]; then
	echo "Image name not specified";
	exit 1;
fi

ARGS="-i -t --rm --name ${USER} -h ${USER}"

#-----------------------------------------------------------------------------
# Doing all the things

OUTPUT=`docker ps -q -f name=${USER}`
if [ "${OUTPUT}" != "" ]; then
	${DOCKER_CMD} exec -it ${USER} ${SHELL_CMD}
	if [ $? -ne 0 ]; then
		${DOCKER_CMD} run ${ARGS} ${IMAGE_NAME} ${SHELL_CMD}
	fi
else
	${DOCKER_CMD} run ${ARGS} ${IMAGE_NAME} ${SHELL_CMD}
fi
