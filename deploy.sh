#!/bin/sh
set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 installer_version"
    echo "Example: $0 1.0.0-beta.1"
    exit 1
fi

installer_version="$1"

./loom -c -n -a ${installer_version} build

aws s3 cp --cache-control max-age=86400 --acl public-read \
    build/builders.loom.installer/jar/builders.loom.installer.jar \
    s3://loom.builders/loom-installer-${installer_version}.jar
