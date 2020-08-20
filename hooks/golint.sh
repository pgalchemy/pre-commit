#!/usr/bin/env bash

set -e

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.
export PATH=$PATH:/usr/local/bin

#!/bin/bash
exit_status=0

if hash golangci-lint 2>/dev/null; then
    if !golangci-lint run --allow-parallel-runners --no-config --deadline=10m --enable=deadcode --enable=golint --enable=varcheck --enable=structcheck --enable=gocyclo --enable=errcheck --enable=gofmt --enable=goimports --enable=misspell --enable=interfacer --enable=unparam --enable=nakedret --enable=prealloc --enable=scopelint --enable=bodyclose --enable=gosec --enable=megacheck; then
        exit_status=1
    fi
else
  exit_status=1
fi

exit ${exit_status}
