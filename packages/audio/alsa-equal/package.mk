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
  make clean
}
make_target() {
  make
}
makeinstall_target() {
  DESTDIR="$INSTALL" make install
}

