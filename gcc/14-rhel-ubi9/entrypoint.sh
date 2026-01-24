#!/usr/bin/env bash

# WARNING: intel setvars scripts mess with a lot of things,
# including our arguments. Save them for later.
ARGS="$@"

. /opt/rh/gcc-toolset-14/enable
. /opt/intel/oneapi/mkl/latest/env/vars.sh
export CC=gcc
export CXX=g++
export FC=gfortran

exec "$ARGS"
