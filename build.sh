#!/bin/bash
set -e

# Bash 4 is required for associative arrays.
if [ "${BASH_VERSINFO[0]}" -lt 4 ]
then
	>&2 echo 'Bash 4+ is required by this script!'
	exit 1
fi

# The INSPIRCD_VERSION variable must be set.
if [ -z "${INSPIRCD_VERSION}" ]
then
	>&2 echo 'You must set the INSPIRCD_VERSION environment variable!'
	exit 1
fi

# The INSPIRCD_REVISION variable may be set.
if [ -z "${INSPIRCD_REVISION}" ]
then
	echo 'INSPIRCD_REVISION is not set; defaulting to 1.'
	INSPIRCD_REVISION='1'
fi

# The directory the current script is in.
export INSPIRCD_ROOT_DIR=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))

# The directory that packages are built in.
export INSPIRCD_BUILD_DIR="${INSPIRCD_ROOT_DIR}/build"
rm -fr ${INSPIRCD_BUILD_DIR}
mkdir -p ${INSPIRCD_BUILD_DIR}

# Build the RPM packages.
source "${INSPIRCD_ROOT_DIR}/rpm/build.sh"

# Build the web interface
source "${INSPIRCD_ROOT_DIR}/www/build.sh"
