#!/usr/bin/env bash

REPO="Phantas0s/gocket"


# List releases.
# `list 10`
list() {
    LIMIT=$1
    gh release list --repo $REPO --limit $LIMIT
}


# View release notes and assets.
# `view 0.1.0`
view() {
    VERSION=$1
    gh release view "v$VERSION" --repo $REPO
}


# Download release asset and install executable to "/usr/local/bin".
# `install 0.1.0`
install() {
    VERSION=$1
    ARCHIVE="gocket_${VERSION}_Linux_x86_64.tar.gz"
    cd `mktemp -d`
    gh release download "v$VERSION" --repo $REPO --pattern $ARCHIVE
    tar xvf $ARCHIVE 
    sudo cp gocket "/usr/local/bin/gocket-v$VERSION"
    sudo chmod 755 "/usr/local/bin/gocket-v$VERSION"
}


# Execute functions as arguments 
# `bash release.sh install 0.1.0` 
$*
