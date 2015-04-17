E10 Repo Manifest for Yocto Project Build System
================================================

This repo provides Repo manifest to setup the Yocto build system for the E10.

Note: If you just want the Synapse layer it is available at:
https://github.com/synapse-wireless/meta-synapse

Getting Started
---------------

**1. Install Repo**

Create bin dir to add to PATH:

    $ mkdir -p ~/.bin

Download the Repo script:

    $ curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo

Make it executable:

    $ chmod +x ~/.bin/repo

Add ~/.bin to your PATH

    $ echo 'export PATH=$HOME/.bin:$PATH' >> ~/.bashrc
    $ source ~/.bashrc

**2. Initialize our project**

Create an empty directory:

    $ mkdir yocto
    $ cd yocto

To setup your repo initially:

    $ repo init -u git://github.com/synapse-wireless/e10-yocto.git

Change branches:

    $ repo init -b something_other_than_master

**3. Pull down the latest repos**

Updates all local repos to the branch you have selected:

    $ repo sync

**4. Initialize Yocto**

    $ export TEMPLATECONF=meta-synapse/conf
    $ source poky/oe-init-build-env

**5. Build images**

    $ bitbake synapse-image-e10-rescue
    $ bitbake synapse-image-e10-ota
