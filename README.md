E10 Repo Manifest for Yocto Project Build System
================================================

This repo provides Repo manifest to setup the Yocto build system for the E10.

Note: If you just want the Synapse layer it is available at:
https://git.synapse-wireless.com/octo/meta-synapse

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

    $ repo init -u git@git.synapse-wireless.com:octo/e10-yocto.git

Pull down the latest repos:

    $ repo sync
