# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for net-proxy/trojan-go"
ACCT_USER_ID=368
ACCT_USER_GROUPS=( trojan-go )

acct-user_add_deps
