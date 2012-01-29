#!/bin/sh
uname -a | grep -qi bsd && MAKE=gmake || MAKE=make
FS_DIR=`pwd`

cd /root
svn co https://opalvoip.svn.sourceforge.net/svnroot/opalvoip/ptlib/branches/v2_8 ptlib
cd ptlib
./configure --prefix=/usr --disable-openldap
${MAKE}
${MAKE} install

cd ..
svn co https://opalvoip.svn.sourceforge.net/svnroot/opalvoip/opal/branches/v3_8 opal 
cd opal
export PKG_CONFIG_PATH=/usr/lib/pkgconfig 
./configure --prefix=/usr --disable-sip --disable-video --disable-java --disable-localspeexdsp
${MAKE}
${MAKE} install
cd ${FS_DIR}
${MAKE} mod_opal-install
