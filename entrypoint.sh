#!/bin/bash

set -e

if [ "$1" = 'server' ]; then
  shift
  # Figure out public address
  export GHIDRA_PUBLIC_HOSTNAME=${GHIDRA_PUBLIC_HOSTNAME:-$(dig +short myip.opendns.com @resolver1.opendns.com)}

  # Add users
  GHIDRA_USERS=${GHIDRA_USERS:-admin}
  if [ ! -e "/ghidra/repositories/users" ] && [ ! -z "${GHIDRA_USERS}" ]; then
    mkdir -p /ghidra/repositories/~admin
    for user in ${GHIDRA_USERS}; do
      echo "Adding user: ${user}"
      echo "-add ${user}" >> /ghidra/repositories/~admin/adm.cmd
    done
  fi

  exec "/ghidra/server/ghidraSvr" console
fi

exec "$@"
