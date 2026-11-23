#!/bin/bash
set -euxo pipefail

rm -rfv /usr/share/cockpit/zfs
rm -fv /usr/share/polkit-1/actions/org.45drives.*
rm -fv /usr/share/polkit-1/rules.d/org.45drives.*

cp -avf "/ctx/system_files"/. /

dnf5 install -y btop grafana grafana-pcp

# Grafana
firewall-offline-cmd --add-service=grafana

# --- Debug ---
ls -l /etc/grafana
ls -ld /etc/grafana

chown -R root:grafana /etc/grafana
chmod 755 /etc/grafana

chown -R grafana:grafana /var/lib/grafana
chmod 755 /var/lib/grafana

# --- Debug ---
ls -l /etc/grafana
ls -ld /etc/grafana

# System services
systemctl enable podman.socket pmproxy.service grafana-server.service
