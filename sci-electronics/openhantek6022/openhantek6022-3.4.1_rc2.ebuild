# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake udev
inherit xdg-utils

DESCRIPTION="Free software for Hantek and compatible USB digital signal oscilloscopes"
HOMEPAGE="https://github.com/OpenHantek/OpenHantek6022"
SRC_URI="https://github.com/OpenHantek/OpenHantek6022/archive/refs/tags/${PV/_/-}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-qt/qtbase-6.2
	>=dev-build/cmake-3.12
	>=sci-libs/fftw-3
	virtual/libusb:1
	virtual/udev
"
RDEPEND="${DEPEND}
	sci-electronics/electronics-menu"
BDEPEND=">=dev-build/cmake-3.5"

PATCHES=(
#	"${FILESDIR}"/${P}-change-cmake-install-prefix.patch
#	"${FILESDIR}"/${P}-fix-doc-location-for-FHS.patch
)

S=${WORKDIR}/OpenHantek6022-${PV/_/-}

src_install() {
	cmake_src_install
	mv "${D}"/usr/share/doc/openhantek/* "${D}"/usr/share/doc/${PF} || die
	rmdir "${D}"/usr/share/doc/openhantek || die "/usr/share/doc/openhantek not empty"
	udev_dorules ${S}/utils/udev_rules/60-openhantek.rules
}

pkg_postinst() {
	udev_reload
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	udev_reload
	xdg_desktop_database_update
	xdg_icon_cache_update
}

