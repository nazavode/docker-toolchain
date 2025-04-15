#!/usr/bin/env bash

. /opt/rh/gcc-toolset-14/enable
export CC=gcc
export CXX=g++
export FC=gfortran

exec "$@"
