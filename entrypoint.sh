#!/usr/bin/env bash

export PATH="${OSXCROSS_TARGET_DIR}/bin:$PATH"
export LD_LIBRARY_PATH="${OSXCROSS_TARGET_DIR}/lib:$LD_LIBRARY_PATH"
export CMAKE_TOOLCHAIN_FILE="${OSXCROSS_TARGET_DIR}/toolchain.cmake"
export OSXCROSS_NO_INCLUDE_PATH_WARNINGS="1"


eval "$("${OSXCROSS_TARGET_DIR}/bin/${OSXCROSS_HOST}-osxcross-conf")"

if [ "$#" = '0' ]
then
  exec bash
else
  exec "$@"
fi
