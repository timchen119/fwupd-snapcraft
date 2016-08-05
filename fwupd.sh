#!/bin/sh
export XDG_DATA_DIRS="$SNAP/usr/share"
exec "$SNAP/libexec/fwupd/fwupd" $@
