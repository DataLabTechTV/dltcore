#!/bin/bash
set -ouex pipefail

rm -rfv /usr/share/cockpit/zfs

cp -avf "/ctx/system_files"/. /

dnf5 install -y btop grafana grafana-pcp

systemctl enable podman.socket pmproxy.service
