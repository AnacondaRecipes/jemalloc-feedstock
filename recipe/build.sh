#!/bin/bash

set -e
set -x

if [[ ${HOST} =~ .*darwin.* ]] ; then
  export LDFLAGS="${LDFLAGS_CC} -Wl,-rpath,${PREFIX}/lib"
fi

./configure --prefix=$PREFIX \
            --build=${BUILD} \
            --host=${HOST}
make -j${CPU_COUNT}
make tests
make check
make install
