# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Qt GUI fontend of v2ray"
HOMEPAGE="https://qv2ray.net/"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
EGIT_SUBMODULES=( '*' '-3rdparty/zxing-cpp' )
EGIT_COMMIT=v${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	net-libs/grpc
	dev-libs/protobuf
	>=media-libs/zxing-cpp-1.1.0
"
RDEPEND="
		dev-libs/openssl:0=
		${DEPEND}
"
BDEPEND="
		dev-qt/linguist-tools:5
"
src_unpack() {
	git-r3_fetch ${EGIT_REPO_URI}
	git-r3_checkout ${EGIT_REPO_URI} "${S}"/${P}
}

src_configure() {
	local mycmakeargs=(
		-DQV2RAY_DISABLE_AUTO_UPDATE=on

	)
	cmake_src_configure
}

src_install(){
	cmake_src_install
}
