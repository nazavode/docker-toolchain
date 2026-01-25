#!/usr/bin/env bash

. /opt/rh/gcc-toolset-14/enable
# Beware: setvars.sh uses global $@ when sourced without arguments;
# make sure to pass at least an argument to avoid forwarding
# docker run args to it:
. /opt/intel/oneapi/setvars.sh --force

export CC=gcc
export CXX=g++
export FC=gfortran

exec "$@"
