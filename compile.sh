#!/bin/bash

#DBGFLAGS="-DDEBUG_NET -DDEBUG_HW -DDEBUG_MAIN -DDBGTS=\"/dev/null\""
DBGFLAGS="-DDEBUG_HW -DDEBUG_MAIN -DDEBUG_SRV"

CC=gcc
ARCH=i686
CFLAGS="-DHAVE_DVB_API_VERSION=3 "$DBGFLAGS
LDFLAGS="-lpthread -lrt"
$CC $CFLAGS -c -o vtuner-network.$ARCH.o vtuner-network.c
$CC $CFLAGS -c -o vtunerd-service.$ARCH.o vtunerd-service.c
$CC $CFLAGS -c -o vtuner-dvb-3.$ARCH.o vtuner-dvb-3.c
$CC $CFLAGS $LDFLAGS -o vtunerd.$ARCH vtuner-network.$ARCH.o vtunerd-service.$ARCH.o vtuner-dvb-3.$ARCH.o vtunerd.c
# $CC $CFLAGS $LDFLAGS -o vtunerc-test.$ARCH vtuner-network.$ARCH.o vtuner-dvb-3.$ARCH.o vtunerc-test.c

CC=/stuff/dm800/build/tmp/cross/bin/mipsel-linux-gcc
ARCH=mipsel
CFLAGS="-fpic -DHAVE_DVB_API_VERSION=3 -DHAVE_DREAMBOX_HARDWARE "$DBGFLAGS
LDFLAGS="-lpthread -lrt"
$CC $CFLAGS -c -o vtuner-network.$ARCH.o vtuner-network.c
$CC $CFLAGS $LDFLAGS -o vtunerc.$ARCH vtuner-network.$ARCH.o vtunerc.c
cp vtunerc.mipsel ipkg-vtunerc/usr/sbin/vtunerc.mipsel
./ipkg-build ipkg-vtunerc

LDFLAGS=$LDFLAGS" -L. -lvtuner-$ARCH"
$CC $CFLAGS -c -o vtuner-dmm-3.$ARCH.o vtuner-dmm-3.c
$CC $CFLAGS -c -o vtunerd-service.$ARCH.o vtunerd-service.c
$CC -shared -Wl,-soname,libvtuner-$ARCH.so -o libvtuner-$ARCH.so vtuner-network.$ARCH.o vtunerd-service.$ARCH.o vtuner-dmm-3.$ARCH.o -lc
$CC $CFLAGS $LDFLAGS -o vtunerd.$ARCH vtunerd.c

CC=/stuff/dm600pvr/build/tmp/cross/bin/powerpc-linux-gcc
ARCH=ppc
CFLAGS="-DHAVE_DREAMBOX_HARDWARE -I/stuff/dm800/build/tmp/work/dreambox-dvbincludes-1-r0/include "$DBGFLAGS
LDFLAGS="-lpthread -lrt"
$CC $CFLAGS -c -o vtuner-network.$ARCH.o vtuner-network.c
$CC $CFLAGS -c -o vtunerd-service.$ARCH.o vtunerd-service.c
$CC $CFLAGS -c -o vtuner-dmm-2.$ARCH.o vtuner-dmm-2.c
$CC $CFLAGS $LDFLAGS -o vtunerd.$ARCH vtuner-network.$ARCH.o vtunerd-service.$ARCH.o vtuner-dmm-2.$ARCH.o vtunerd.c

CC=/stuff/dm600pvr/build/tmp/cross/bin/powerpc-linux-gcc
ARCH=db2
CFLAGS="-DHAVE_DVB_API_VERSION=3 -DMAX_DEMUX=10 "$DBGFLAGS
LDFLAGS="-lpthread -lrt"
$CC $CFLAGS -c -o vtuner-network.$ARCH.o vtuner-network.c
$CC $CFLAGS -c -o vtunerd-service.$ARCH.o vtunerd-service.c
$CC $CFLAGS -c -o vtuner-dvb-3.$ARCH.o vtuner-dvb-3.c
$CC $CFLAGS $LDFLAGS -o vtunerd.$ARCH vtuner-network.$ARCH.o vtunerd-service.$ARCH.o vtuner-dvb-3.$ARCH.o vtunerd.c
