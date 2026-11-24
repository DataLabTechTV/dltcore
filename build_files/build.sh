#!/bin/bash
set -euxo pipefail

rm -rfv /usr/share/cockpit/zfs
rm -fv /usr/share/polkit-1/actions/org.45drives.*
rm -fv /usr/share/polkit-1/rules.d/org.45drives.*

cp -avf "/ctx/system_files"/. /

dnf5 install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf5 config-manager disable terra

dnf5 install -y btop pcp-pmda-libvirt
dnf5 -y --enable-repo=terra install fantasquesansmono-nerd-fonts

# Firewall
firewall-offline-cmd --add-service=grafana

# System services
systemctl enable podman.socket pmproxy.service
