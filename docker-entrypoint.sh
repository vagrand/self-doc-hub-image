#!/bin/sh
set -e
# Copy bundled translations into the data directory; existing files are never overwritten.
mkdir -p "$DOCS_HUB_DATA_DIR/translations"
cp -n /opt/docs-hub/translations/*.yaml "$DOCS_HUB_DATA_DIR/translations/"
exec docs-hub "$@"
