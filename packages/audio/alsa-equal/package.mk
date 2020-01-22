PKG_NAME="alsa-equal"
PKG_VERSION="112017"
PKG_ARCH="any"
PKG_LICENSE=""
PKG_SITE="https://github.com/raedwulf/alsaequal"
PKG_URL="https://github.com/raedwulf/alsaequal/archive/master.tar.gz"
PKG_DEPENDS_TARGET="toolchain caps alsa-lib alsa-utils ncurses systemd"
PKG_SHORTDESC="Alsaequal is a real-time adjustable equalizer plugin for ALSA. It can be adjusted using any ALSA compatible mixer, e.g. alsamixergui."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  cd $PKG_BUILD
  mkdir -p $INSTALL/usr/lib/alsa-lib/
  sed -i '/CC\(.*\)= gcc/d' ./Makefile
  sed -i '/LD\(.*\)= gcc/d' ./Makefile
  sed -i '/LDFLAGS :=\(.*\)/d' ./Makefile
  sed -i '/CFLAGS :=\(.*\)/d' ./Makefile
}
make_target() {
   make ARCH="" LDFLAGS="-O2 -shared -lasound" \
    CFLAGS="-I. -O2 -funroll-loops -ffast-math -fPIC -DPIC"
}
makeinstall_target() {
    make DESTDIR=$INSTALL install
}
post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config
    cp -PR $PKG_DIR/config/* $INSTALL/usr/config
  mkdir -p $INSTALL/usr/lib/alsa/
    mv $INSTALL/usr/lib/alsa-lib/* $INSTALL/usr/lib/alsa/
    rm -r $INSTALL/usr/lib/alsa-lib
}

