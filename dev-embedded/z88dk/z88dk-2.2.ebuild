# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="z88dk - the z80 dvelopment kit."
HOMEPAGE="https://github.com/z88dk/z88dk"
SRC_URI="https://github.com/z88dk/z88dk/releases/download/v${PV}/z88dk-src-${PV}.tgz \
http://nightly.z88dk.org/zsdcc/zsdcc_r13131_src.tar.gz"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=sys-devel/gcc-8 \
>=dev-libs/boost-1.71 \
>=dev-util/re2c-1.3 \
>=sys-apps/texinfo-6.7 \
>=app-text/texi2html-1.82 \
>=net-misc/curl-7.68 \
>=dev-perl/App-cpanminus-1.704.4 \
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-util/ccache-3.7 \
>=dev-util/ragel-6.10 \
>=app-text/dos2unix-7.4 \
>=dev-perl/Modern-Perl-1.202.0.211 \
perl-gcpan/CPU-Z80-Assembler \
"

S="${WORKDIR}/${PN}"

src_prepare() {
	default
#	sed -i 's/$MAKE/$MAKE $MAKEOPTS/' ${S}/build.sh
	mv ${S}/../src/sdcc-build ${S}/src
	rmdir ${S}/../src
}

src_compile() {
	export BUILD_SDCC=1
	${S}/build.sh -i "${EPREFIX}"/usr || die "build.sh failed"
}

src_install() {
	default
	mv ${D}/bin ${D}/usr
	mv ${D}/share/z88dk ${D}/usr/share
	rmdir ${D}/share
}
