#!/bin/bash
set -ouex pipefail

rm -rfv /usr/share/cockpit/zfs
rm -fv /usr/share/polkit-1/actions/org.45drives.*
rm -fv /usr/share/polkit-1/rules.d/org.45drives.*

cp -avf "/ctx/system_files"/. /

dnf5 install -y btop grafana grafana-pcp

systemctl enable podman.socket pmproxy.service
