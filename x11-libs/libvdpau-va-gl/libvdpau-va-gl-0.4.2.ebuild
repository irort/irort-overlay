# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="VDPAU driver with OpenGL/VAAPI backend"
HOMEPAGE="https://github.com/i-rinat/libvdpau-va-gl"
SRC_URI="https://github.com/i-rinat/libvdpau-va-gl/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="x11-libs/libvdpau"
RDEPEND="${DEPEND}"

src_configure() {
	localmycmakeargs=(
		-DCMAKE_BUILD_TYPE="Release"
	)
	cmake_src_configure
}
