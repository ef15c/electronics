# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


# Taken from https://github.com/vowstar/vowstar-overlay/ and updated...
EAPI=8

inherit udev unpacker

DESCRIPTION="Tools for Segger J-Link JTAG adapters"
HOMEPAGE="https://www.segger.com/jlink-software.html"
SRC_URI="JLink_Linux_V${PV/./}_x86_64.deb"

S="${WORKDIR}/JLink_Linux_V${PV/./}_x86_64"

LICENSE="SEGGER"
SLOT="0"
KEYWORDS="~amd64"
IUSE="udev"
QA_PREBUILT="*"

RESTRICT="fetch strip"
RDEPEND="
	media-libs/fontconfig
	media-libs/freetype
	sys-devel/gcc
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
"

pkg_nofetch() {
	einfo "Segger requires you to accept their license agreement before downloading."
	einfo "Download DEB archive from here:"
	einfo "  ${HOMEPAGE}"
	einfo ""
	einfo "And then copy it in DISTDIR (usually /var/cache/distfiles/)"
}

src_unpack() {
	mkdir "${S}" || die
	cd "${S}" || die
	unpack_deb "${A}"
}

src_install() {
	mkdir -p "${S}/lib/udev" || die
	mv "${S}/etc/udev/rules.d" "${S}/lib/udev/rules.d" || die
	cp -R "${S}/lib" "${S}/opt" "${S}/usr" "${D}" || die
}

pkg_postinst() {
	if use udev ; then
		udev_reload
	fi
}

pkg_postrm() {
	if use udev ; then
		udev_reload
	fi
}
