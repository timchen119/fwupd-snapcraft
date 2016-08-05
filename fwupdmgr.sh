#!/bin/sh
export GIO_EXTRA_MODULES="$SNAP/usr/lib/x86_64-linux-gnu/gio/modules"
exec "$SNAP/bin/fwupdmgr" $@