# Copyright 1999-2013 FOSS-Group, Germany
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="virtual package to pull in FOSS-Cloud packages"
HOMEPAGE="http://www.foss-cloud.org/"

LICENSE="EUPL"
SLOT="0"
KEYWORDS="amd64"
IUSE="+cifs +ipmi +zabbix"

DEPEND=""
RDEPEND="cifs? ( net-fs/cifs-utils )
	ipmi? ( sys-apps/ipmitool )
	zabbix? ( net-analyzer/zabbix[agent] )
	sys-block/nbd
	>=net-misc/ucarp-1.5.2-r3
	~app-misc/fc-misc-scripts-1.2.3
	~net-nds/sst-ldap-schemas-1.2.5
	~sys-apps/fc-node-integration-1.2.15
	~sys-apps/fc-prov-backup-kvm-1.0.9
	~x11-themes/fc-artwork-1.0.4
	~www-apps/vm-manager-1.2.15
	~sys-apps/fc-configuration-1.2.15
	~sys-kernel/foss-cloud-bin-3.8.1
	~app-emulation/fc-broker-daemon-1.2.10
"

S="${WORKDIR}"

src_compile() {
	echo "${PV}" > "foss-cloud_version"

	cat > "os-release" << EOF
NAME=FOSS-Cloud
VERSION="${PV}"
ID=foss-cloud
EOF

	echo 'CONFIG_PROTECT_MASK="/etc/os-release /etc/foss-cloud_version"' > 99foss-cloud
}

src_install() {
	insinto /etc
	doins foss-cloud_version os-release

	doenvd 99foss-cloud
}
