# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils git-r3 xdg-utils

DESCRIPTION="CEmu is a third-party TI-84 Plus CE / TI-83 Premium CE calculator emulator"
HOMEPAGE="https://github.com/CE-Programming/CEmu"
EGIT_REPO_URI="https://github.com/CE-Programming/CEmu.git"

LICENSE="GPL-3 \
MIT"

SLOT="0"
KEYWORDS="~amd64 ~arm"

DEPEND="media-libs/libpng[apng] \
dev-qt/qtcore:5 \
dev-qt/qtnetwork:5"

RDEPEND="${DEPEND}"
BDEPEND="dev-vcs/git"

src_prepare() {
	default
}

src_configure() {
	default
	cd gui/qt
	eqmake5 -r CEmu.pro
}

src_compile() {
	cd gui/qt
	default
}

src_install() {
	cd gui/qt
	emake INSTALL_ROOT="${D}" install
	mkdir -p ${D}/usr/share/applications
	cp resources/linux/cemu.desktop ${D}/usr/share/applications
	mkdir -p ${D}/usr/share/mime/packages
	cp resources/linux/cemu.xml ${D}/usr/share/mime/packages
	for length in 512 256 192 160 128 96 72 64 48 42 40 36 32 24 22 20 16; do \
		mkdir -p ${D}/usr/share/icons/hicolor/${length}x${length}/apps ;
		cp resources/icons/linux/cemu-${length}x${length}.png ${D}/usr/share/icons/hicolor/${length}x${length}/apps/cemu.png ;
	done
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
