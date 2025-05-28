# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils xdg

DESCRIPTION="Sudoku game and solver"
HOMEPAGE="https://github.com/ef15c/Sudoku"
SRC_URI="https://github.com/ef15c/Sudoku/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,widgets]
	dev-games/sudslven
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	eqmake6
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	doicon images/sudoku.png
	make_desktop_entry /usr/bin/SudokuInterfaceQt Sudoku /usr/share/pixmap/sudoku.png Game
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

