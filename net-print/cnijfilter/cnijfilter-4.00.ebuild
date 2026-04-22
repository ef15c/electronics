# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

MY_P="${PN}-source-${PV}-1"

DESCRIPTION="IJ Printer Driver"
HOMEPAGE="https://www.canon.fr/support/consumer/products/printers/pixma/mg-series/pixma-mg3550.html?type=drivers&os=Linux%20(64-bit)"
SRC_URI="https://gdlp01.c-wss.com/gds/5/0100005515/01/${MY_P}.tar.gz"

S="${WORKDIR}"/${MY_P}

LICENSE="Canon-IJ"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/libusb:1
	dev-libs/libxml2:=
	net-print/cups"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}"/1_changes.patch
	"${FILESDIR}"/2_cups.patch
	"${FILESDIR}"/3_fixes.patch
)

src_prepare() {
	default
	DIRS="libs cngpij cngpijmnt pstocanonij backend backendnet cmdtocanonij cnijbe lgmon2"
# bscc2sts cnijnpr
	LIBDIR=com/libs_bin$(usex amd64 64 32)
	for d in ${DIRS}; do
		mv "${d}"/configure.{in,ac} || die
	done
	echo "AC_INIT([${PN}], [${PV}])" >> configure.ac
	echo "AM_INIT_AUTOMAKE" >> configure.ac
	echo "AC_CONFIG_SUBDIRS([${DIRS}])" >> configure.ac
	echo "AC_CONFIG_FILES([Makefile])" >> configure.ac
	echo "AC_OUTPUT()" >> configure.ac
	echo "SUBDIRS= ${DIRS}" >> Makefile.am
	sed -i \
		-e "/^CFLAGS/d" \
		*/configure.ac \
		cnijbe/src/Makefile.am || die
	eautoreconf
	cd ${LIBDIR}
	rm libcn*.so || die
	ln -sf libcnbpcnclapicom.so.4.0.0 libcnbpcnclapicom.so || die
	ln -sf libcnnet.so.1.2.2 libcnnet.so || die

	cd -
}

src_configure() {
	econf --enable-progpath="${EPREFIX}/usr/bin" LDFLAGS="-L${S}/${LIBDIR} ${LDFLAGS}"
}

src_install() {
	default
	insinto /usr/share/ppd/cupsfilters
	doins ppd/*ppd
	dolib.so ${LIBDIR}/*
	mkdir -p "${D}"/usr/libexec/cups || die
	mv "${D}"/usr/lib64/cups/filter "${D}"/usr/libexec/cups || die
	rmdir "${D}"/usr/lib64/cups || die
	mv "${D}"/usr/lib/cups/backend "${D}"/usr/libexec/cups || die
	rmdir "${D}"/usr/lib/cups || die
	dolib.so 427/libs_bin$(usex amd64 64 32)/*
	insinto /usr/lib64/bjlib
	doins 427/database/*
}
