# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Build, test, and document your APIs faster"
HOMEPAGE="https://www.getpostman.com/"
SRC_URI="
	https://dl.pstmn.io/download/version/${PV}/linux64 -> ${P}-amd64.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/nss
	x11-libs/gtk+:3
	x11-libs/pango
"

QA_PRESTRIPPED="
	opt/postman-bin/resources/app/node_modules/native_modules/rg
	opt/postman-bin/resources/app/node_modules/native_modules/watcher.node
	opt/postman-bin/resources/app/node_modules/native_modules/prebuilds/linux-x64/node.napi.glibc1.node
	opt/postman-bin/resources/app/node_modules/native_modules/prebuilds/linux-x64/node.napi.glibc.node
	opt/postman-bin/resources/app/node_modules/native_modules/prebuilds/linux-x64/node.napi.node
	opt/postman-bin/resources/app/node_modules/native_modules/prebuilds/linux-x64/node.napi1.node
	opt/postman-bin/postman
	opt/postman-bin/libvk_swiftshader.so
	opt/postman-bin/libGLESv2.so
	opt/postman-bin/libffmpeg.so
	opt/postman-bin/libEGL.so
	opt/postman-bin/chrome-sandbox
	opt/postman-bin/chrome_crashpad_handler
"

S="${WORKDIR}/${MY_PN^}/app"

src_install() {
	insinto "/opt/${PN}"

	doins -r *
	fperms 755 "opt/${PN}/Postman"
	fperms 755 "opt/${PN}/postman"

	newicon -s 128 "resources/app/assets/icon.png" "${MY_PN}.png"
	domenu "${FILESDIR}/${MY_PN}.desktop"
}
