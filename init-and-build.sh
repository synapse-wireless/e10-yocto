#!/bin/bash

die() {
	echo $*
	exit 1
}

[ -z "${GIT_BRANCH}" ] && die "You must specify GIT_BRANCH"
BUILD_BRANCH=${GIT_BRANCH##*/}
BUILD_VERSION=${GIT_BRANCH##*/v}

[ "x${BUILD_BRANCH}" = "xmaster" ] && die "We do not build master"
[ "x${BUILD_VERSION}" = "x${GIT_BRANCH}" ] && die "bad branch name"

# add $HOME/.bin to our PATH
export PATH=$HOME/.bin:$PATH

# check for repo script
type -p repo
if [ $? -ne 0 ]; then
    mkdir ${HOME}/.bin/
    curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > \
		${HOME}/.bin/repo
    chmod +x ${HOME}/.bin/repo
fi

if [ -z "${GIT_COMMIT}" ]; then
	GIT_COMMIT=$(git rev-parse HEAD)
fi
echo "${GIT_COMMIT}" > .git/refs/heads/${BUILD_BRANCH}

# grab repo data
repo init -u . -b ${BUILD_BRANCH} || die "unable to repo init"

# pull down repos
repo sync || die "unable to repo sync"

# initialize Yocto
export TEMPLATECONF=meta-synapse/conf
source poky/oe-init-build-env

# build our images
bitbake synapse-image-e10-rescue || die "unable to build rescue image"
bitbake synapse-image-e10-ota || die "unable to build ota image"

# build extra packages
bitbake \
	nodejs \
	python-ujson \
	zeromq \
	python-pip \
	python-tornado \
	python-pycrypto \
	python-pyzmq \
	iproute2 \
	net-tools \
	iputils \
	iptables \
	nano \
	micro-emacs \
	monit \
	openvpn \
	python-pytz \
	screen \
	ruby \
	rsync \
	file \
	usbutils \
	socat \
	bzip2 \
	cronie \
	wpa-supplicant \
	ppp \
	rp-pppoe \
	|| die "unable to build extra packages"

# build package index
bitbake package-index || die "unable to generate package index"

# rsync packages
rsync -avH tmp/deploy/ipk/{all,armv5te,at91sam9x5ek} \
	jenkins@artifactory.synapse-wireless.com:e10/${BUILD_VERSION}/ \
	|| die "unable to rsync"

exit 0
