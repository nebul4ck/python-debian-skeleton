#!/bin/bash

set -u -e -o pipefail

# Check python version
if [[ ($1 == "2.7") || ($1 == "3.5") ]]; then
	PYTHON_VERSION=$1
else
	help
	exit 1
fi

# if not equals to three arguments supplied, display usage
if [ $# -ne 3 ]; then
	help
	exit 1
fi

# check whether user had supplied -h or --help . If yes display usage
if [[ ($# == "--help") || ($# == "-h")  ]]; then
	help
	exit 0
fi

# MANDATORY JENKINS VARS
SET_MODE=$2
REPO=$3
JENKINS_BASE="/var/lib/jenkins/workspace"

# SET ENVIRONMENT VARIABLES
BASE="."
PACKAGE_PATH="${BASE}/${REPO}"

if [ $SET_MODE == "jenkins" ]; then
	BASE="$JENKINS_BASE"
	PACKAGE_PATH="${BASE}/${REPO}/${REPO}"
elif [ $SET_MODE != "local" ]; then
	help
	exit 1
fi

# COMMONS VARIABLES
DEB_DIR_NAME=$(echo ${REPO} | tr - _)
MODULE_SRC_PATH="./src/${DEB_DIR_NAME}/"
CONFIG_DIR="${PACKAGE_PATH}/etc/${REPO}"
BINARY_DIR="${PACKAGE_PATH}/usr/bin"
DIST_PACKAGE_PATH="${PACKAGE_PATH}/usr/lib/python${PYTHON_VERSION}/dist-packages/${DEB_DIR_NAME}/"

help() {
	echo "Usage: ./make_package.sh python_version environment ${REPO}"
	echo "python_version: [2.7|3.5]"
	echo "environment: jenkins|local"
	exit 1
}

# CHECK FOLDERS AND CREATE IF DOES NOT EXISTS
if [ ! -d $PACKAGE_PATH ]; then
	mkdir -p $PACKAGE_PATH
fi

if [ ! -d $DIST_PACKAGE_PATH ]; then
	mkdir -p $DIST_PACKAGE_PATH
fi

if [ ! -d $CONFIG_DIR ]; then
	mkdir -p $CONFIG_DIR
fi

if [ ! -d $BINARY_DIR ]; then
	mkdir -p $BINARY_DIR
fi

# Sync source code with package folder
rsync -av --delete -r --exclude '*pyc' --exclude 'tests' \
	${MODULE_SRC_PATH}/* ${DIST_PACKAGE_PATH}

# Copy configuration files
cp ./src/${REPO}.conf-prod ${CONFIG_DIR}/${REPO}.conf && \
	echo "${REPO}.conf-prod file synchronized"
cp ./src/logging.conf-prod ${CONFIG_DIR}/logging.conf && \
	echo "logging.conf-prod file synchronized"

# Copy executable file to system folder
cp ./src/${DEB_DIR_NAME}.py ${BINARY_DIR}/${REPO} && \
	echo "${DEB_DIR_NAME}.py file synchronized"

# Add executable permissions to executable file
chmod +x ${BINARY_DIR}/${REPO} && \
	echo "attr changed!"

exit 0