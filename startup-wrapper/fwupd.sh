#!/bin/sh
export XDG_DATA_DIRS="$SNAP/usr/share"
if [ ! -f $SNAP_DATA/etc/fwupd.conf ]
then
        mkdir -p $SNAP_DATA/etc
        cp $SNAP/etc/fwupd.conf $SNAP_DATA/etc/fwupd.conf
fi
if [ ! -d $SNAP_DATA/etc/pki ]
then
        cp -r $SNAP/etc/pki $SNAP_DATA/etc/
fi
exec "$SNAP/libexec/fwupd/fwupd" $@
