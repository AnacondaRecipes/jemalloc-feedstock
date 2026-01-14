#!/bin/bash

set -exuo pipefail

export EXTRA_CONFIGURE_ARGS="--prefix=${PREFIX} --disable-static --disable-cxx --with-jemalloc-prefix=local --with-install-suffix=local"
$RECIPE_DIR/build-jemalloc.sh