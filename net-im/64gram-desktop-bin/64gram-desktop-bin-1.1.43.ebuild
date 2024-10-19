# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature xdg

DESCRIPTION="Unofficial desktop client for Telegram (binary package)"
HOMEPAGE="https://github.com/TDesktop-x64/tdesktop"
SRC_URI="
	https://github.com/TDesktop-x64/tdesktop/archive/v${PV}.tar.gz -> tdesktop-${PV}.tar.gz
	amd64? ( https://github.com/TDesktop-x64/tdesktop/releases/download/v${PV}/64Gram_${PV}_linux.zip )
"

S="${WORKDIR}"

LICENSE="GPL-3-with-openssl-exception"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="mirror"

QA_PREBUILT="usr/bin/64gram-desktop"

RDEPEND="
	sys-libs/glibc
	dev-libs/glib:2
	>=media-libs/fontconfig-2.13
	media-libs/freetype:2
	virtual/opengl
	x11-libs/gtk+:3[X,wayland]
	x11-libs/libX11
	>=x11-libs/libxcb-1.10
"
BDEPEND="app-arch/unzip"

src_prepare() {
	default

	sed -i -e \
		's/^Exec=@CMAKE_INSTALL_FULL_BINDIR@\/telegram-desktop/Exec=\/usr\/bin\/64gram-desktop/' \
		"${WORKDIR}/tdesktop-${PV}"/lib/xdg/io.github.tdesktop_x64.TDesktop.service || die
}

src_install() {
	newbin Telegram 64gram-desktop
	# Disable the official Telegram Desktop updater
	insinto /usr/share/64Gram/externalupdater.d
	newins - telegram-desktop.conf <<<"${EPREFIX}/usr/bin/64gram-desktop"

	local icon_size
	for icon_size in 16 32 48 64 128 256 512; do
		newicon -s "${icon_size}" \
			"${WORKDIR}/tdesktop-${PV}/Telegram/Resources/art/icon${icon_size}.png" \
			64gram.png
	done

	domenu "${FILESDIR}"/io.github.tdesktop_x64.TDesktop.desktop
	insinto /usr/share/dbus-1/services
	doins "${WORKDIR}/tdesktop-${PV}"/lib/xdg/io.github.tdesktop_x64.TDesktop.service
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "spell checker support" app-text/enchant
}
