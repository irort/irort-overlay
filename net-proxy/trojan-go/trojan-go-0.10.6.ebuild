# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd go-module

DESCRIPTION="A Trojan proxy written in Go."
HOMEPAGE="
		https://github.com/p4gefau1t/trojan-go
		https://p4gefau1t.github.io/trojan-go"
SRC_URI="
		https://github.com/p4gefau1t/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/irort/gentoo-deps/releases/download/${P}/${P}-deps.tar.xz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
#IUSE="api +client custom forward mysql nat other server"

RESTRICT="mirror test"

DEPEND="
		acct-group/trojan-go
		acct-user/trojan-go"
RDEPEND="
		${DEPEND}
		app-alternatives/v2ray-geoip
		app-alternatives/v2ray-geosite
		dev-libs/openssl:0="
BDEPEND="dev-lang/go"

src_prepare() {
		sed -i '/^User=/s/nobody/trojan-go/;/^User=/aDynamicUser=true' example/*.service || die
		default
}

src_compile() {
		# local MY_TAGS
		ego build -tags "full" -v -work -o "bin/trojan-go" \
				-trimpath -ldflags="-s -w -buildid="
}

src_install() {
		dobin bin/trojan-go
		
		insinto /etc/trojan-go
		doins example/*.json

		newinitd "${FILESDIR}/trojan-go.initd" trojan-go
		systemd_newunit example/trojan-go.service trojan-go.service
		systemd_newunit example/trojan-go@.service trojan-go@.service
}
