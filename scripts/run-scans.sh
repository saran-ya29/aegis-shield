#!/usr/bin/env bash
set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORTS_DIR="${ROOT_DIR}/reports"
SAMPLE_APP_DIR="${ROOT_DIR}/sample-app"

mkdir -p "${REPORTS_DIR}"

echo "======================================================="
echo "   AEGIS SHIELD: AUTOMATED SECURITY TOOLING SUITE (CI)  "
echo "======================================================="

# 1. Python dependency scan
echo "[1/4] Running pip-audit..."
pip-audit -r "${SAMPLE_APP_DIR}/requirements.txt" -f json -o "${REPORTS_DIR}/pip-audit-report.json" || true

# 2. JavaScript dependency scan
echo "[2/4] Running npm audit..."
(cd "${SAMPLE_APP_DIR}" && npm audit --json > "${REPORTS_DIR}/npm-audit-report.json" || true)

# 3. Secret scan
echo "[3/4] Running gitleaks..."
gitleaks detect --source "${ROOT_DIR}" -v --report-path "${REPORTS_DIR}/gitleaks-report.json" || true

# 4. Dynamic Application Security Testing
echo "[4/4] Running OWASP ZAP..."
python3 "${SAMPLE_APP_DIR}/app.py" &
APP_PID=$!
sleep 3

docker run --rm --net=host -v "${REPORTS_DIR}:/zap/wrk:rw" -t ghcr.io/zaproxy/zaproxy:stable \
    zap-baseline.py -t http://localhost:8080 -r zap-report.html -J zap-report.json || true

kill -9 "${APP_PID}" 2>/dev/null || true

echo "======================================================="
echo "   ALL SCANS EXECUTED. REPORTS WRITTEN TO /reports      "
echo "======================================================="