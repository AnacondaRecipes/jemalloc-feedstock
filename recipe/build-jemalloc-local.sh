#!/bin/bash

set -exuo pipefail

export EXTRA_CONFIGURE_ARGS="--disable-cxx --with-jemalloc-prefix=local --with-install-suffix=local"
$RECIPE_DIR/build.sh