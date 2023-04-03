# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="STM8 GDB debugger"
HOMEPAGE="https://stm8-binutils-gdb.sourceforge.io"
SRC_URI="https://ftp.gnu.org/gnu/gdb/gdb-8.1.tar.xz"

LICENSE="GPL-3"
SLOT="0"
IUSE="test"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-util/dejagnu )"

# Disable test phase when test USE flag is disabled
RESTRICT="!test? ( test )"

PATCHES=(
    "${FILESDIR}"/${P}-0000-fix-segmentation-fault-in-tui-mode.patch
    "${FILESDIR}"/${P}-0001-First-commit-for-stm8-binutils-gdb.patch
    "${FILESDIR}"/${P}-0002-added-clear_proceed_status-in-run_command_1-causing-.patch
    "${FILESDIR}"/${P}-0005-Fixed-printf-formatting-warnings.patch
    "${FILESDIR}"/${P}-0006-Numerous-changes-and-bug-fixes.patch
    "${FILESDIR}"/${P}-0007-Added-gc-sections-and-hi8-lo8-hh8.patch
    "${FILESDIR}"/${P}-0008-Add-STM8-reloc-ops-by-default.patch
    "${FILESDIR}"/${P}-0009-Fixed-typo-in-STM8-opcode-list-definition.patch
    "${FILESDIR}"/${P}-0010-Replaced-C99-code-with-ANSI-C-equivalent.patch
    "${FILESDIR}"/${P}-0011-Fix-bccm-instruction.patch
    "${FILESDIR}"/${P}-0012-Include-stm8-while-building-multi-architecture-gdb.patch
    "${FILESDIR}"/${P}-0013-Implemented-.s-short-addressing-mode-modifer-to-inde.patch
    "${FILESDIR}"/${P}-0015-Refactored-lo8-hi8-hh8-and-removed-the-special-push-.patch
    "${FILESDIR}"/${P}-0016-Fixed-compilation-error-in-gdb-stm8-tdep.c.patch
    "${FILESDIR}"/${P}-0017-Compilation-issue-with-python-3.7.patch
    "${FILESDIR}"/${P}-0018-Python-3.9-segementation-fault.patch
)

S=${WORKDIR}/gdb-8.1

CTARGET=stm8-none-elf32

src_configure() {
    ./configure --build=${CHOST} --host=${CHOST} --target=${CTARGET} --program-prefix=stm8- --prefix="${EPREFIX}"/usr --includedir="${EPREFIX}"/usr/${CTARGET}/include --datarootdir="${EPREFIX}"/usr/${CTARGET}/share
}
