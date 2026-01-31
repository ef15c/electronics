# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="https://frama-c.com"

LICENSE="BSD LGPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND="${DEPEND}
	dev-ml/opam
	media-gfx/graphviz
	x11-libs/gtksourceview:3.0
	gnome-base/libgnomecanvas"
BDEPEND=""

pkg_postinst() {
	elog "This package only installs frama-c prerequisites."
	elog "To finalize the installation, run opam install frama-c"
	elog "in a user shell."
}
