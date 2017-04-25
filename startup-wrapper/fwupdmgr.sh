#!/bin/sh
export XDG_DATA_DIRS="$SNAP/usr/share"
export GIO_EXTRA_MODULES="$SNAP/usr/lib/x86_64-linux-gnu/gio/modules"

#TODO: once polkit is integrated to snappy it should revisted, currently this works for root-only.
XDG_RUNTIME_DIR="$SNAP_DATA/run/user/$(id -u)"
if [ ! -d $XDG_RUNTIME_DIR ]
then
	mkdir -p $XDG_RUNTIME_DIR
fi

#A workaround for the fchown secomp denial that crash fwupd, used in fu_main_daemon_update_metadata called as_store_to_file and then gio.
#audit: type=1326 audit(1472623873.021:86): auid=4294967295 uid=0 gid=0 ses=4294967295 pid=1468 comm="fwupd"
#exe="/snap/uefi-fw-tools/x1/libexec/fwupd/fwupd" sig=31 arch=c000003e syscall=93 compat=0 ip=0x7fe5f9e93a77 code=0x0
#Also check:  https://bugs.launchpad.net/ubuntu/+source/snapd/+bug/1581310
if [ "$1" = "refresh" ] && [ -f $SNAP_DATA/cache/app-info/xmls/fwupd.xml ]
then
  mv -f $SNAP_DATA/cache/app-info/xmls/fwupd.xml $SNAP_DATA/cache/app-info/xmls/fwupd.xml.backup
fi

exec "$SNAP/bin/fwupdmgr" $@
