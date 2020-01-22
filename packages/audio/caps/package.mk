PKG_NAME="caps"
PKG_VERSION="0.9.26"
PKG_ARCH="any"
PKG_LICENSE="GNUv3"
PKG_SITE="http://quitte.de/dsp/caps.html"
PKG_URL="http://quitte.de/dsp/caps_$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain Python3 binutils"
PKG_SHORTDESC="CAPS is a collection of audio plugins comprising basic virtual guitar amplification and a small range of classic effects, signal processors and generators of mostly elementary and occasionally exotic nature."
#PKG_AUTORECONF="yes"

#PKG_TOOLCHAIN="make"
#PKG_CONFIGURE_OPTS_TARGET="--help"

pre_make_target() {
  cd $PKG_BUILD
  mkdir $INSTALL
  sed -i '/CC = g++/d' ./Makefile
  sed -i 's+STRIP = strip+STRIP = echo +g' ./Makefile
  sed -i "s+PREFIX = /usr+PREFIX = $INSTALL/usr+g" ./Makefile
  make clean
}

make_target() {
  make \
    ARCH="" \
    #LDFLAGS="" 
    #CFLAGS="" 
    OPTS="-O3 -ffast-math -funroll-loops -Wall -fPIC -DPIC"
}

makeinstall_target() {
  make install
}

