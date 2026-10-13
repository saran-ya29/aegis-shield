# Aegis Shield — Security Tooling Reference & CI/CD Integration

This document defines the automated application security testing suite for the WorkforceOS platform. It provides setup instructions, capability benchmarks, false-positive triage procedures, and CI pipeline quality-gate rules for backend, frontend, and platform teams.

---

## 1. Quickstart: One-Command Execution

All tools run locally and in CI using a single invocation:

### Windows (PowerShell)
```powershell
powershell -ExecutionPolicy Bypass -File scripts\run-scans.ps1