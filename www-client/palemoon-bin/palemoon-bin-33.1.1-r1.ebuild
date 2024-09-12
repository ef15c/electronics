# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker
inherit xdg-utils

DESCRIPTION="Pale Moon Web Browser"
HOMEPAGE="https://www.palemoon.org/"

BIN_PN="${PN/-bin/}"
BIN_PVR="${PVR/r/}"
RESTRICT="strip"

SRC_URI="https://download.opensuse.org/repositories/home:/stevenpusser:/palemoon-GTK3/Debian_11/armhf/${BIN_PN}_${BIN_PVR}.gtk3_armhf.deb"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~arm"

DEPEND=""
RDEPEND="x11-libs/gtk+:3"
BDEPEND="app-alternatives/gzip"

src_unpack() {
	mkdir "${S}" || die
	cd "${S}" || die
	unpack_deb "${A}"
}

src_install() {
	mv "${S}/usr/share/doc/palemoon" "${S}/usr/share/doc/${PF}" || die
	gzip -d "${S}/usr/share/doc/${PF}/"*.gz || die
	cp -R "${S}/usr" "${D}" || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
