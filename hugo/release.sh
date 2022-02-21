#!/usr/bin/env bash

REPO="gohugoio/hugo"


# List hugo releases.
# `list 10`
list() {
    LIMIT=$1
    gh release list --repo $REPO --limit $LIMIT
}


# View hugo release notes and assets.
# `view 0.92.1`
view() {
    VERSION=$1
    gh release view "v$VERSION" --repo $REPO
}


# Download hugo release asset and install executable to "/usr/local/bin".
# `install 0.92.1`
install() {
    VERSION=$1
    ARCHIVE="hugo_extended_${VERSION}_Linux-64bit.tar.gz"
    cd `mktemp -d`
    gh release download "v$VERSION" --repo $REPO --pattern $ARCHIVE
    tar xvf $ARCHIVE 
    chmod g+rx,o+rx hugo
    sudo cp hugo "/usr/local/bin/hugo-v$VERSION"
}


# Execute functions as arguments 
# `bash release.sh install 0.92.1` 
$*
