#!/bin/sh
set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 installer_version loom_version"
    echo "Example: $0 1.0.0-beta.1 1.0.0-alpha.3"
    exit 1
fi

installer_version="$1"
loom_version="$2"

sed \
    -e "s/@LOOM_INSTALLER_VERSION@/${installer_version}/" \
    -e "s/@LOOM_VERSION@/${loom_version}/" \
    scripts/installer.sh > build/installer.sh

aws s3 cp --cache-control max-age=900 --acl public-read \
    build/installer.sh s3://loom.builders/
