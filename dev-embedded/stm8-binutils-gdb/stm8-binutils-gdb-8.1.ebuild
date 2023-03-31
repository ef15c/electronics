# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="STM8 toolchain with GDB debugger"
HOMEPAGE="https://stm8-binutils-gdb.sourceforge.io"
SRC_URI="https://sphpn.dynu.com/download/stm8-binutils-gdb-sources-2021-07-18.tar.gz
https://ftp.gnu.org/gnu/binutils/binutils-2.30.tar.xz
https://ftp.gnu.org/gnu/gdb/gdb-8.1.tar.xz"

LICENSE="GPL-3"
SLOT="0"
IUSE="test"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-util/dejagnu )"

# Disable test phase when test USE flag is disabled
RESTRICT="!test? ( test )"

S=${WORKDIR}/binutils-2.30

PATCHES=(
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0001-First-commit-for-stm8-binutils-gdb.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0002-added-clear_proceed_status-in-run_command_1-causing-.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0003-Changed-the-run-functionality-to-mimic-running-nativ.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0004-Added-debug-option-to-gas-to-enable-debugging-printo.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0005-Fixed-printf-formatting-warnings.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0006-Numerous-changes-and-bug-fixes.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0007-Added-gc-sections-and-hi8-lo8-hh8.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0008-Add-STM8-reloc-ops-by-default.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0009-Fixed-typo-in-STM8-opcode-list-definition.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0010-Replaced-C99-code-with-ANSI-C-equivalent.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0011-Fix-bccm-instruction.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0012-Include-stm8-while-building-multi-architecture-gdb.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0013-Implemented-.s-short-addressing-mode-modifer-to-inde.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0014-Fixed-bit-operand-relocation.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0015-Refactored-lo8-hi8-hh8-and-removed-the-special-push-.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0016-Fixed-compilation-error-in-gdb-stm8-tdep.c.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0017-Compilation-issue-with-python-3.7.patch
	"${WORKDIR}"/stm8-binutils-gdb-sources/binutils_patches/0018-Python-3.9-segementation-fault.patch
)

src_unpack() {
	cd  ${WORKDIR}
	tar -xf  ${DISTDIR}/stm8-binutils-gdb-sources-2021-07-18.tar.gz
	mkdir binutils-2.30
	tar -xf ${DISTDIR}/gdb-8.1.tar.xz --strip-components=1 --directory=binutils-2.30
	tar -xf ${DISTDIR}/binutils-2.30.tar.xz
}

CTARGET=stm8-none-elf32

src_configure() {
	./configure --build=${CHOST} --host=${CHOST} --target=${CTARGET} --program-prefix=stm8- --prefix="${EPREFIX}"/usr --includedir="${EPREFIX}"/usr/${CTARGET}/include --datarootdir="${EPREFIX}"/usr/${CTARGET}/share
}
