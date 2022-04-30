# shellcheck shell=sh
#!/usr/bin/env sh
alias hugo_list='gh release list --repo gohugoio/hugo'
alias hugo_view='gh release view --repo gohugoio/hugo'
alias hugo_download='gh release download --repo gohugoio/hugo'

# Download release asset and install executable to "/usr/local/bin".
# `hugo_install 0.1.0`
hugo_install() {
    VERSION=$1
    BINARY="hugo"
    PATTERN="hugo_extended_${VERSION}_Linux-64bit.tar.gz"
    cd "$(mktemp -d)" || exit 1
    hugo_download "v$VERSION" --pattern "$PATTERN"
    tar xvf "$PATTERN"
    sudo cp "$BINARY" "/usr/local/bin/$BINARY-v$VERSION"
    sudo chmod 755 "/usr/local/bin/$BINARY-v$VERSION"
    unset VERSION BINARY PATTERN
}

# Link name without version to specific version
# `hugo_link 0.1.0`
hugo_link() {
    VERSION=$1
    BINARY="hugo"
    sudo ln -sf "/usr/local/bin/$BINARY-v$VERSION" "/usr/local/bin/$BINARY"
    unset VERSION BINARY
}
