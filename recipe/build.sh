#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./build-aux

set -exuo pipefail

# Static TLS has caused users to experience some errors of the form
# "libjemalloc.so.2: cannot allocate memory in static TLS block"
#
# We disable this feature until we better understand how to avoid loader errors
# of this type

EXTRA_CONFIGURE_ARGS="--prefix=${PREFIX} --disable-static"

if [[ ${target_platform} =~ linux.* ]]; then
  # Fixes:
  #  * As conda-forge/anaconda patches the glibc headers to have an inline
  #    aligned_alloc implementation, we need to mangle aligned_alloc to use
  #    a separate name, we cannot override it.
  #  * With the old glibc version/headers, we also run into
  #    https://github.com/jemalloc/jemalloc/issues/1237
  if [[ "${target_platform}" == "linux-aarch64" ]]; then
    EXTRA_CONFIGURE_ARGS="${EXTRA_CONFIGURE_ARGS} --with-lg-page=16"
  fi
  ./configure --disable-tls \
              --disable-initial-exec-tls \
              --disable-aligned-alloc \
	            ${EXTRA_CONFIGURE_ARGS}
elif [[ "${target_platform}" == "osx-arm64" ]]; then
  ./configure --with-lg-page=14 ${EXTRA_CONFIGURE_ARGS:-}
else
  ./configure --disable-tls ${EXTRA_CONFIGURE_ARGS:-}
fi
make -j${CPU_COUNT}
make check
make install
