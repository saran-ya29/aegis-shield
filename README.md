# Aegis Shield

[![Security Suite](https://img.shields.io/badge/Security-pip--audit%20%7C%20npm%20audit%20%7C%20Gitleaks%20%7C%20OWASP%20ZAP-blue.svg)](#security-tooling-suite)
[![Standards](https://img.shields.io/badge/OWASP-ASVS%20v4.0%20(L1%2FL2)%20%7C%20WSTG-green.svg)](#documentation-index)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20WSL2-informational.svg)](#quickstart-running-scans)

Aegis Shield is an application security governance framework and automated vulnerability testing suite built for the **WorkforceOS** platform. It covers the full Phase 1 security lifecycle: STRIDE threat modeling, multi-domain secure coding standards, an automated CI/CD-compatible vulnerability scanner, and pre-implementation authentication architecture reviews.

---

## Repository Structure

```text
aegis-shield/
├── docs/                                # Architecture & Governance Documentation
│   ├── architecture/                    # Asset boundaries, data flows, and risk tracking
│   │   ├── assets-and-components.md     # System inventory (C1–C11) and asset classifications (A1–A8)
│   │   ├── stride-threat-model.md       # 30-threat STRIDE evaluation matrix
│   │   └── risk-register.md             # Formal risk register (AS-001 through AS-008)
│   ├── coding-standards/                # Domain-specific secure coding standards
│   │   ├── backend-checklist.md         # Python / FastAPI security controls
│   │   ├── frontend-checklist.md        # Next.js UI, DOM sanitization, and token handling
│   │   └── devops-checklist.md          # CI/CD, container hardening, and infrastructure gates
│   ├── decisions/                       # Architecture Decision Records (ADRs)
│   │   └── 003-auth-draft-specification.md # Default Decision Rule record for auth baseline
│   └── reviews/                         # Pre-Implementation Security Design Reviews
│       ├── auth-design-review.md        # 9-point ASVS Level 2 auth review & agreed fixes
│       └── fullstack-handoff.md         # Next.js authentication UI/UX technical constraints
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