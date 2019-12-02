#!/usr/bin/env bash

set -e

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.
export PATH=$PATH:/usr/local/bin

#!/bin/bash
exit_status=0


for file in "$@"; do
  goimports -l -w "$(dirname "$file")"
  if ! golangci-lint run --no-config --deadline=10m --enable=deadcode --enable=golint --enable=varcheck --enable=structcheck --enable=gocyclo --enable=errcheck --enable=gofmt --enable=goimports --enable=misspell --enable=interfacer --enable=unparam --enable=nakedret --enable=prealloc --enable=scopelint --enable=bodyclose --enable=gosec --enable=megacheck "$(dirname "$file")"; then
        exit_status=1
    fi
done

exit ${exit_status}
