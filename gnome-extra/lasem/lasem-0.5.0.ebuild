# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A C/GObject-based SVG/Mathml renderer and editor"
HOMEPAGE="https://blogs.gnome.org/emmanuel/category/lasem/"
LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection"

inherit versionator gnome2

SRC_URI="mirror://gnome/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.xz"

RDEPEND="
	>=dev-libs/glib-2.44.1:2
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+
	x11-libs/pango
	x11-libs/cairo[svg]
	dev-libs/libxml2
	introspection? ( >=dev-libs/gobject-introspection-1:= )
	sys-devel/bison
	sys-devel/flex
	app-office/lyx
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.12
	>=dev-util/intltool-0.35.0
	dev-libs/gobject-introspection-common
	virtual/pkgconfig
"
RESTRICT="mirror"

src_configure() {
	gnome2_src_configure \
		$(use_enable introspection) # \
	# 	--docdir="${EPREFIX}/usr/share/doc/${PF}"
}

src_install() {
	gnome2_src_install
	rm -rf "${D}"/usr/doc || die
}
