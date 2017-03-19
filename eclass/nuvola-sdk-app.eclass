# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: nuvola-sdk-app.eclass
# @MAINTAINER:
# gmt@be-evil.net
# @AUTHOR:
# probably Greg Turner
# @BLURB: Laziness-maximizing helper for nuvola-player plugins
# @DESCRIPTION:
# Standard framework for implementing ebuilds for nuvola-app-foo
# nuvola-player plugins ("apps").  The default behavior is
# simply to point to https://github.com/tiliado/${PN}.git (for -9999
# ebuilds, the only schema currently implemented), create a python3_4
# or python3_5 wrapper via python-single-r1, and, otherwise,
# to act mostly like autotools-utils.eclass.

# only EAPI6 supported
case "${EAPI:-0}" in
	6) ;;
	*) die "EAPI=${EAPI:-0} is not supported" ;;
esac

# only PV=9999 is supported
case "${PV}" in
	9999)
		EGIT_REPO_URI="https://github.com/tiliado/${PN}.git"
		EGIT_CLONE_TYPE="shallow"
		inherit git-r3
		;;
	*) die "Only -9999 package versions supported" ;;
esac

LICENSE="BSD-2"

: ${NUVOLA_SDK_APP_NO_AUTO_PYTHON:=no}

if [[ ${NUVOLA_SDK_APP_NO_AUTO_PYTHON} == no ]]; then
	PYTHON_COMPAT=( python{3_4,3_5} )
	inherit python-single-r1
	DEPENDS="${PYTHON_DEPS}"
	REQUIRED_USE="${PYTHON_REQUIRED_USE}"
fi

IUSE="${IUSE} +launcher"

inherit vala
DEPENDS+="
	media-libs/nuvola-sdk
	launcher? ( $(vala_depend) )
"

EXPORT_FUNCTIONS src_prepare src_configure src_compile

RDEPENDS="${DEPENDS}"

nuvola-sdk-app_src_prepare() {
	eapply_user
	if [[ ${NUVOLA_SDK_APP_NO_AUTO_PYTHON} == no ]]; then
		python_setup
		python_fix_shebang -f "${S}/configure"
	fi
	if use launcher; then
		vala_src_prepare
		mkdir -p "${T}"/valac-wrapper || die
		rm -f "${T}"/valac-wrapper/valac || die
		cat <<-EOF > "${T}"/valac-wrapper/valac
			#!/bin/sh
			${VALAC} "\$@"
		EOF
		chmod -c a+x "${T}"/valac-wrapper/valac || die
		export PATH="${T}/valac-wrapper:${PATH}"
	fi
	default
}

nuvola-sdk-app_src_configure() {
	whattodo=(
		"${S}"/configure \
			--prefix="${EPREFIX}/usr" \
			$(use launcher && echo --with-dbus-launcher) \
			"$@"
	)
	einfo "Executing configure: ${whattodo[*]}"
	"${whattodo[@]}"
}

nuvola-sdk-app_src_compile() {
	emake all
}
