# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 multiprocessing

DESCRIPTION="tldr.sh pages, converted to man pages for offline use"
HOMEPAGE="https://github.com/tldr-pages/tldr"
SRC_URI=""
EGIT_REPO_URI="https://github.com/tldr-pages/tldr.git"

LICENSE="CC-BY-4.0"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-text/pandoc sys-process/parallel"

src_compile() {
	mkdir man
	cd pages || die
	parallel \
		-j$(makeopts_jobs) \
		--verbose \
		--halt now,fail=1 \
		'pandoc -s -f markdown -t man -o ../man/{= s#^[a-z]+/(.+)\.md$#\1#; $_ = Q($_) =}.1t {= $_ = Q($_) =}' \
		::: {common,linux}/*.md
}

src_install() {
	for i in man/*; do
		doman "$i"
	done
}
