# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_4 python3_5 )
PYTHON_REQ_USE="threads(+)"
DISTUTILS_SINGLE_IMPL=1
EGIT_REPO_URI="https://github.com/tiliado/diorite.git"
EGIT_CLONE_TYPE="shallow"

inherit git-r3 distutils-r1 gnome2 waf-utils vala

DESCRIPTION="Bleeding-edge GUI framework utilized by nuvola player"
HOMEPAGE="https://github.com/tiliado/diorite"
KEYWORDS="~amd64 ~x86"
SLOT="0"
SRC_URI=""
LICENSE="BSD-2"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
	>=dev-libs/glib-2.44.1-r1
	>=x11-libs/gtk+-3.20.9:3
	>=dev-python/pyparsing-2.1.0[${PYTHON_USEDEP}]
"
DEPEND="
	$(vala_depend)
	${RDEPEND}
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

pkg_fetch() {
	git-r3_pkg_fetch
}

src_prepare() {
	eapply_user
	distutils-r1_src_prepare
}

python_prepare_all() {
	distutils-r1_python_prepare_all
	vala_src_prepare
}

python_configure() {
	waf-utils_src_configure
}

src_install() {
    echo "\"${WAF_BINARY}\" --destdir=\"${D}\" --no-ldconfig install"
    "${WAF_BINARY}" --destdir="${D}" --no-ldconfig install || die "Make install failed"

    # Manual document installation
    einstalldocs
}

pkg_postinst() {
	gnome2_icon_cache_update
}
