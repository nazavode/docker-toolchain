#!/usr/bin/env bash

. /mojo-venv/bin/activate
export MOJO_PATH=$(modular config mojo.path)
export MODULAR_HOME="${HOME}/.modular"
export PATH="${MOJO_PATH}/bin:${PATH}"

exec "$@"
