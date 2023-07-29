# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="CEmu is a third-party TI-84 Plus CE / TI-83 Premium CE calculator emulator"
HOMEPAGE="https://github.com/CE-Programming/CEmu"
SRC_URI="https://github.com/CE-Programming/CEmu/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-3 \
MIT"

SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/libpng[apng] \
dev-qt/qtcore:5"
RDEPEND="${DEPEND}"
BDEPEND="dev-vcs/git"

PATCHES=(
	${FILESDIR}/0000-fix-compilation-errors.patch
)

RESTRICT="nostrip"

src_prepare() {
	cp -r ${FILESDIR}/zdis core/debug
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
}
