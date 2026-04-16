#!/bin/sh
set -e

DATA_DIR="${ZETA4G_HOME:-/data}"

# Initialize database on first run
if [ ! -d "${DATA_DIR}/.zeta4g" ]; then
  echo "==> Initializing Zeta4G database at ${DATA_DIR}..."
  zeta4gctl init --home "${DATA_DIR}" -y
fi

case "$1" in
  start)
    shift
    echo "==> Starting Zeta4G server..."
    exec zeta4gd --home "${DATA_DIR}" "$@"
    ;;
  init)
    shift
    exec zeta4gctl init --home "${DATA_DIR}" "$@"
    ;;
  shell)
    shift
    exec zeta4gs "$@"
    ;;
  *)
    exec "$@"
    ;;
esac
