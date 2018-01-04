#!/bin/bash

set -e
set -x

./autogen.sh --prefix=$PREFIX \
             --build=${BUILD} \
             --host=${HOST}
make -j${CPU_COUNT} ${VERBOSE_AT}
make tests
make check
make install
