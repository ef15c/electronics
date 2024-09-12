# Copyright 2024 Christian Schoffit
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PMV=${PV%%\.*}
DESCRIPTION="Oxford Oberon-2 Compiler"
HOMEPAGE="https://spivey.oriel.ox.ac.uk/corner/Installing_OBC_release_3.1"
SRC_URI="https://github.com/Spivoxity/${PN}-${PMV}/archive/refs/tags/rel-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-lang/ocaml \
x11-libs/gtksourceview:3.0"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/${PN}-${PMV}-rel-${PV}

PATCHES=(
	"$FILESDIR/${P}-0000-fix-install-path.patch"
)

src_prepare() {
	autoreconf
	eapply_user
}

src_install() {
	make install
}
