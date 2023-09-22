# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="tldr.sh pages, converted to man pages for offline use"
HOMEPAGE="https://github.com/tldr-pages/tldr"
SRC_URI=""
EGIT_REPO_URI="https://github.com/tldr-pages/tldr.git"

LICENSE="CC-BY-4.0"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-text/pandoc"

src_compile() {
	mkdir man
	cd pages || die
	for i in {common,linux}/*.md; do
		name=${i%.md}
		name=${name#*/}
		pandoc -s -f markdown -t man -o "../man/$name.1t" "$i" || die
	done
}

src_install() {
	for i in man/*; do
		doman "$i"
	done
}
