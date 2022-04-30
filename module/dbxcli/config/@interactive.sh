#!/usr/bin/env sh
alias dbxcli_list='gh release list --repo dropbox/dbxcli'
alias dbxcli_view='gh release view --repo dropbox/dbxcli'
alias dbxcli_download='gh release download --repo dropbox/dbxcli'

# Download release asset and install executable to "/usr/local/bin".
# `dbxcli_install 0.1.0`
dbxcli_install() {
    VERSION=$1
    BINARY="dbxcli"
    PATTERN="dbxcli_linux_amd64"
    cd "$(mktemp -d)" || exit 1
    dbxcli_download "v$VERSION" --pattern "$PATTERN"
    sudo cp "$BINARY" "/usr/local/bin/$BINARY-v$VERSION"
    sudo chmod 755 "/usr/local/bin/$BINARY-v$VERSION"
    unset VERSION BINARY PATTERN
}

# Link name without version to specific version
# `dbxcli_link 0.1.0`
dbxcli_link() {
    VERSION=$1
    BINARY="dbxcli"
    sudo ln -sf "/usr/local/bin/$BINARY-v$VERSION" "/usr/local/bin/$BINARY"
    unset VERSION BINARY
}
