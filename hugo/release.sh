#!/usr/bin/env bash

REPO="gohugoio/hugo"
BINARY="hugo"

pattern() {
    VERSION=$1
    echo "hugo_extended_${VERSION}_Linux-64bit.tar.gz"
}


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
    cd `mktemp -d`
    gh release download "v$VERSION" --repo $REPO --pattern `pattern $VERSION`
    tar xvf $PATTERN
    sudo cp $BINARY "/usr/local/bin/$BINARY-v$VERSION"
    sudo chmod 755 "/usr/local/bin/$BINARY-v$VERSION"
}


# Link name without version to specific version
# `link 0.1.0`
link() {
    VERSION=$1
    sudo ln -sf "/usr/local/bin/$BINARY" "/usr/local/bin/$BINARY-v$VERSION"
}


# Execute functions as arguments 
# `bash release.sh install 0.1.0` 
$*
