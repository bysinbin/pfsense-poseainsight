#!/bin/sh
set -e
echo "=== Installing PoseaInsight (Deep Traffic Analytics) for pfSense ==="
if [ "$(id -u)" -ne 0 ]; then
    echo "[!] Error: Run as root."
    exit 1
fi
SCRIPT_DIR="$(cd "$(dirname "$0")/.." 2>/dev/null && pwd)"
if [ ! -d "${SCRIPT_DIR}/pfsense-pkg" ]; then
    TMP_DIR="/tmp/poseainsight_install"
    rm -rf "${TMP_DIR}"
    mkdir -p "${TMP_DIR}"
    fetch -q -o "${TMP_DIR}/main.tar.gz" "https://github.com/bysinbin/pfsense-poseainsight/archive/refs/heads/main.tar.gz"
    tar -xzf "${TMP_DIR}/main.tar.gz" -C "${TMP_DIR}"
    SCRIPT_DIR="${TMP_DIR}/pfsense-poseainsight-main"
fi

mkdir -p /usr/local/pkg /usr/local/www /var/etc/poseafilter
cp "${SCRIPT_DIR}/pfsense-pkg/usr/local/pkg/poseainsight.inc" /usr/local/pkg/poseainsight.inc
cp "${SCRIPT_DIR}/pfsense-pkg/usr/local/pkg/poseainsight.xml" /usr/local/pkg/poseainsight.xml
cp "${SCRIPT_DIR}/pfsense-pkg/usr/local/www/poseainsight.php" /usr/local/www/poseainsight.php

php -r '
require_once("/etc/inc/config.inc");
global $config;
$found = false;
foreach ($config["installedpackages"]["package"] ?? [] as $p) {
    if (($p["name"] ?? "") === "poseainsight") { $found = true; break; }
}
if (!$found) {
    $config["installedpackages"]["package"][] = [
        "name" => "poseainsight",
        "descr" => "PoseaInsight Deep Traffic Analytics for pfSense",
        "website" => "https://github.com/bysinbin/pfsense-poseainsight",
        "version" => "1.0.0",
        "status" => "Stable",
        "configurationfile" => "poseainsight.xml"
    ];
}
$mfound = false;
foreach ($config["installedpackages"]["menu"] ?? [] as $m) {
    if (($m["name"] ?? "") === "PoseaInsight") { $mfound = true; break; }
}
if (!$mfound) {
    $config["installedpackages"]["menu"][] = [
        "name" => "PoseaInsight",
        "section" => "Status",
        "url" => "/poseainsight.php"
    ];
}
write_config("Installed PoseaInsight package");
'
echo "[+] PoseaInsight successfully installed!"
