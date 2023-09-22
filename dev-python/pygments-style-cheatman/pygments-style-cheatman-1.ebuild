# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )
inherit distutils-r1

DESCRIPTION="pygments style for app-doc/cheat-sh-pages"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pygments"
BDEPEND=""

src_unpack() {
	mkdir "${S}"
	cp "${FILESDIR}"/* "${S}"/
}

#distutils_enable_tests pytest
