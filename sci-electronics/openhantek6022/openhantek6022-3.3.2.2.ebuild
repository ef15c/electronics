# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev
inherit xdg-utils

DESCRIPTION="Free software for Hantek and compatible USB digital signal oscilloscopes"
HOMEPAGE="https://github.com/OpenHantek/OpenHantek6022"
SRC_URI="https://github.com/OpenHantek/OpenHantek6022/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-qt/qtprintsupport-5.4
	>=dev-qt/qtopengl-5.4
	>=dev-qt/qtwidgets-5.4
	>=dev-qt/qtgui-5.4
	>=dev-qt/qtcore-5.4
	>=sci-libs/fftw-3
	virtual/libusb:1
	virtual/udev
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-util/cmake-3.5"

PATCHES=(
	"${FILESDIR}"/${P}-change-cmake-install-prefix.patch
	"${FILESDIR}"/${P}-fix-doc-location-for-FHS.patch
	"${FILESDIR}"/${P}-disable-package-udev-rule-installation.patch
	"${FILESDIR}"/${P}-add-support-for-YiXingDianZiKeJi-YX-DSO-MSDO.patch
)

S=${WORKDIR}/OpenHantek6022-${PV}

src_prepare() {
	default_src_prepare
	mkdir -p ${S}/build
}

src_configure() {
	cd ${S}/build
	cmake ..
}

src_compile() {
	cd ${S}/build
	default_src_compile
}

src_install() {
	cd ${S}/build
	default_src_install
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

