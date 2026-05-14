# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A very powerful, highly configurable, small editor with syntax coloring"
HOMEPAGE="https://www.scintilla.org/SciTE.html"
SRC_URI="https://www.scintilla.org/${PN}${PV//./}.tgz -> ${P}.tgz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~riscv x86"

RDEPEND="
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${PN}/gtk"

src_compile() {
	# prepare make options
	local emake_pars=("GTK3=1")

	emake -C "${WORKDIR}/lexilla/src" "${emake_pars[@]}"
	emake -C "${WORKDIR}/scintilla/gtk" "${emake_pars[@]}"
	emake "${emake_pars[@]}"
}

# want to use the base src_install() as base_src_install()

src_install() {
	GTK3=1 default
	dosym SciTE /usr/bin/scite
}
