# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="cheat.sh pages, converted to man pages for offline use"
HOMEPAGE="https://github.com/chubin/cheat.sheets"
SRC_URI=""
EGIT_REPO_URI="https://github.com/chubin/cheat.sheets.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="dev-python/pygments dev-python/pygments-style-cheatman"

src_compile() {
	mkdir man
	cd sheets || die
	for i in *; do
		# TODO sheets in subdirs, _info.yaml
		test -d "$i" && continue
		# monospaced=false uses \f that's actually supported by man-db
		pygmentize -f roff -O style=cheatman,monospaced=false -l sh -o "../man/$i.1cs" "$i" || die
	done
}

src_install() {
	for i in man/*; do
		doman "$i"
	done
}
