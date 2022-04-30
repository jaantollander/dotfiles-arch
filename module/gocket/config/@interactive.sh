#!/usr/bin/env sh
alias gocket_list='gh release list --repo Phantas0s/gocket'
alias gocket_view='gh release view --repo Phantas0s/gocket'
alias gocket_download='gh release download --repo Phantas0s/gocket'

# Download release asset and install executable to "/usr/local/bin".
# `gocket_install 0.1.0`
gocket_install() {
    VERSION=$1
    BINARY="gocket"
    PATTERN="gocket_${VERSION}_Linux_x86_64.tar.gz"
    cd "$(mktemp -d)" || exit 1
    gocket_download "v$VERSION" --pattern "$PATTERN"
    tar xvf "$PATTERN"
    sudo cp "$BINARY" "/usr/local/bin/$BINARY-v$VERSION"
    sudo chmod 755 "/usr/local/bin/$BINARY-v$VERSION"
    unset VERSION BINARY PATTERN
}

# Link name without version to specific version
# `gocket_link 0.1.0`
gocket_link() {
    VERSION=$1
    BINARY="gocket"
    sudo ln -sf "/usr/local/bin/$BINARY-v$VERSION" "/usr/local/bin/$BINARY"
    unset VERSION BINARY
}
