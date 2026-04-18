# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="I2C, MicroWire and SPI EEPROM/Flash chip Programmer"
HOMEPAGE="https://github.com/bigbigmdm/IMSProg"
SRC_URI="https://github.com/bigbigmdm/IMSProg/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libusb
	dev-qt/qtwidgets
	dev-qt/qtnetwork
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	dev-qt/linguist-tools
	dev-util/pkgconf
	sys-apps/systemd-utils
"

S=${WORKDIR}/IMSProg-${PV}
