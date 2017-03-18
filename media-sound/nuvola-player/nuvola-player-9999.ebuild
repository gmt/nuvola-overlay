# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"
EGIT_REPO_URI="https://github.com/tiliado/nuvolaplayer.git"
EGIT_CLONE_TYPE="shallow"
VALA_MIN_API_VERSION="0.26"

inherit git-r3 python-single-r1 gnome2 vala waf-utils

DESCRIPTION="Cloud music integration for the Linux desktop."
HOMEPAGE="https://github.com/tiliado/nuvolaplayer"
KEYWORDS="~amd64 ~x86"
SLOT="0"
SRC_URI=""
LICENSE="BSD-2"
IUSE="" #unity

WAF_BINARY="${S}/nerfwaf"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-libs/glib-2.44.1-r1[dbus]
	>=x11-libs/gtk+-3.20.9:3[introspection,X]
	>=x11-libs/libX11-1.6.4
	>=dev-libs/json-glib-1.2.2[introspection]
	>=app-arch/libarchive-3.2.2-r1
	>=x11-libs/diorite-${PV}
	>=net-libs/webkit-gtk-2.14.5:4[introspection]
	>=x11-libs/libnotify-0.7.6-r3[introspection]
	sys-apps/util-linux
	app-crypt/libsecret[introspection,vala]
	dev-libs/libdbusmenu[introspection]
"

# TODO: unity?
# TODO: required libarchive useflags?
# TODO: required webkit-gtk useflags?
# TODO: libsecret,libnotify,etc: introspection useflag really req.?
# TODO: useflag for libdbusmenu-glib?

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
	einfo "Installing nerfed waf wrapper"
	cp "${FILESDIR}"/nerfwaf "${S}" || die nerfwaf install fail
	chmod a+x "${S}/nerfwaf" || die nerfwaf perm fail
	vala_src_prepare
}

python_prepare() {
	vala_src_prepare
}

pkg_postinst() {
	gnome2_icon_cache_update
}
