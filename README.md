# Aegis Shield

[![Security Suite](https://img.shields.io/badge/Security-pip--audit%20%7C%20npm%20audit%20%7C%20Gitleaks%20%7C%20OWASP%20ZAP-blue.svg)](#security-tooling-suite)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20WSL2-informational.svg)](#one-command-execution)

Aegis Shield is an application security governance and automated vulnerability testing framework built for the **WorkforceOS** platform. It integrates threat modeling (STRIDE), domain-specific secure coding standards, and an automated scanning engine covering Software Composition Analysis (SCA), secret detection, and Dynamic Application Security Testing (DAST).

---

## Repository Structure

```text
aegis-shield/
├── docs/                                # Architecture & Governance Documentation
│   ├── architecture/                    # Asset boundaries and data flow diagrams
│   └── coding-standards/                # Domain-specific secure coding standards
│       ├── backend-checklist.md         # Python / API security controls
│       ├── frontend-checklist.md        # UI, DOM, and token handling rules
│       └── devops-checklist.md          # CI/CD, container, and infrastructure gates
├── reports/                             # Generated Security Test Artifacts
│   ├── gitleaks-report.json             # Secret audit findings across Git history
│   ├── npm-audit-report.json            # Node.js dependency vulnerability report
│   ├── pip-audit-report.json            # Python dependency CVE scan output
│   ├── zap-report.html                  # OWASP ZAP baseline scan (HTML report)
│   ├── zap-report.json                  # OWASP ZAP findings (JSON format)
│   └── zap.yaml                         # ZAP automation framework execution plan
├── sample-app/                          # Multi-Tier Vulnerability Testing Fixture
│   ├── app.py                           # Flask backend with simulated endpoints
│   ├── index.html                       # Frontend DOM client
│   ├── package.json                     # Node.js dependency manifest
│   ├── package-lock.json                # Locked Node.js dependency tree
│   └── requirements.txt                 # Python dependency specifications
├── scripts/                             # Unified Execution Runners
│   ├── run-scans.ps1                    # Native Windows PowerShell runner
│   └── run-scans.sh                     # POSIX shell runner for Linux CI/CD agents
├── TOOLS.md                             # Security tooling reference & triage matrix
└── README.md                            # Project overview and runbook