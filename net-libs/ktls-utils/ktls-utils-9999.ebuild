# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 autotools linux-info

DESCRIPTION="Kernel TLS helper utilities"
HOMEPAGE="https://github.com/oracle/ktls-utils"
EGIT_REPO_URI="https://github.com/oracle/ktls-utils.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-apps/keyutils net-libs/gnutls"
RDEPEND="${DEPEND}"

# Required kernel options
CONFIG_CHECK="TLS"
CONFIG_REQUIRED="Kernel TLS support (CONFIG_TLS)"


pkg_pretend() {
    # Inform the user about required kernel options if they're missing
    linux-info_pkg_setup
}
src_prepare() {
    default
    eautoreconf
}

src_configure() {
    econf
}

src_install() {
    default
    dodoc README.md
	
    # Install the init script
    newinitd "${FILESDIR}/tlshd.initd" tlshd

	if [[ -f "INSTALL.md" ]]; then
        dodoc INSTALL.md
    fi
    if [[ -d "docs" ]]; then
        docinto docs
        dodoc docs/*
    fi
}

# /usr/local/portage/net-libs/ktls-utils/ktls-utils-9999.ebuild



