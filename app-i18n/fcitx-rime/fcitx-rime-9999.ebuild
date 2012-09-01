# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils git-2

DESCRIPTION="Rime Support for Fcitx"
HOMEPAGE="http://code.google.com/p/rimeime/"
EGIT_REPO_URI="git://github.com/fcitx/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-i18n/rime-data
	app-i18n/fcitx
	app-i18n/librime
	x11-libs/libnotify
	"
DEPEND="${RDEPEND}"

src_prepare() {
	# dont build data resource here, already provided by app-i18n/rime-data
	sed -i -e 's|add_subdirectory(data)||' CMakeLists.txt || die
	# search correct data path
	sed -i -e 's|/usr/share/rime/brise|/usr/share/rime-data|' \
		cmake/FindBrise.cmake || die
	# change the patch
	sed -i -e '/ibus_rime_traits\.shared_data_dir/s/= shared_data_dir/= \
		\"\/usr\/share\/rime-data\"/' src/fcitx-rime.c || die
}

