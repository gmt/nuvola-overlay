# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="SDK for building Nuvola Player's web app scripts"
HOMEPAGE="https://github.com/tiliado/nuvolasdk"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PYTHON_COMPAT=( python{3_4,3_5} )

EGIT_REPO_URI="https://github.com/tiliado/nuvolasdk.git"
EGIT_CLONE_TYPE="shallow"

inherit git-r3 distutils-r1

DEPEND="
	dev-python/scour
	gnome-extra/lasem
	gnome-base/librsvg
	virtual/imagemagick-tools[svg]
	media-sound/nuvola-player
"
RDEPEND="${DEPEND}"
