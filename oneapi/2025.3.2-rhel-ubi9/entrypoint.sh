#!/usr/bin/env bash

. /opt/rh/gcc-toolset-14/enable
. /opt/intel/oneapi/setvars.sh
export CC=icx
export CXX=icpx

exec "$@"
