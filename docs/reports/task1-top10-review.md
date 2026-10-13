# Task 1 — Top 10 Threat Review & Team Alignment

## Executive Summary
Across the 30 identified STRIDE threats for WorkforceOS, the top 10 highest-ranked risks were prioritized based on their risk score ($\text{Likelihood} \times \text{Impact}$)[cite: 1]. These risks were presented to the respective domain owners (Backend, Frontend, Platform/Infra, Identity, and AI) to align on immediate remediation priorities for Task 2[cite: 1].

## Top 10 Priority Threats

| Rank | Threat ID | STRIDE | Score | Description | Owner | Required Control |
| :---: | :--- | :--- | :---: | :--- | :--- | :--- |
| **1** | **AS-011** | Info Disclosure | **25 (Critical)** | BOLA/IDOR on employee REST endpoints exposing salaries, bank details, and PII[cite: 1]. | Backend | Server-side tenant and user ID authorization checks on all query parameters. |
| **2** | **AS-012** | Info Disclosure | **20 (Critical)** | Guessable/sequential URLs on payslip PDF downloads leaking other employees' payslips[cite: 1]. | Backend | Cryptographic signed URLs with strict session-based ownership verification. |
| **3** | **AS-016** | Info Disclosure | **20 (Critical)** | Unencrypted API keys, DB credentials, or signing secrets committed to Git repositories[cite: 1]. | Platform | Pre-commit secret scanning (Gitleaks) and pipeline block rules[cite: 1]. |
| **4** | **AS-021** | Elevation of Priv | **20 (Critical)** | JWT claim tampering or improper role validation elevating standard staff to finance admin[cite: 1]. | Backend | Asymmetric signature verification and centralized role-based authorization guards. |
| **5** | **AS-001** | Spoofing | **16 (High)** | Credential brute-forcing at the edge reverse proxy[cite: 1]. | Identity | Edge rate limiting, IP throttling, and account lockout policies. |
| **6** | **AS-013** | Info Disclosure | **16 (High)** | Prompt injection against AI assistant extracting cross-tenant chat history or PII[cite: 1]. | AI / ML | Strict prompt-boundary framing and output filtering of PII. |
| **7** | **AS-015** | Info Disclosure | **16 (High)** | Raw request bodies logging credentials or auth tokens into centralized telemetry[cite: 1]. | Backend | Request body sanitization and redaction middleware before log ingestion. |
| **8** | **AS-024** | Elevation of Priv | **16 (High)** | Parameter manipulation allowing submitters to self-approve expenses or invoices[cite: 1]. | Backend | Separation of duties enforcement; submitter ID cannot match approver ID. |
| **9** | **AS-002** | Spoofing | **15 (High)** | Stored or reflected XSS stealing admin session cookies in Next.js portal[cite: 1]. | Frontend | Enforce `HttpOnly`, `Secure`, and `SameSite=Strict` cookie flags; strict CSP headers. |
| **10** | **AS-008** | Repudiation | **15 (High)** | Rogue execution of off-cycle payroll runs without transactional audit logging[cite: 1]. | Backend | Append-only, immutable audit logging with actor attribution for all financial mutations[cite: 1]. |

## Domain Feedback & Sign-Off
- **Backend API Team**: Agreed that AS-011 and AS-012 are the most urgent risks. Implementing object-level authorization across FastAPI endpoints in Task 2.
- **Frontend Team**: Confirmed all cookies will use `HttpOnly` and `SameSite=Strict` attributes to block script-based cookie theft (AS-002).
- **Platform / CI Team**: Will enforce automated pre-commit hooks using Gitleaks to prevent credential leakage (AS-016)[cite: 1].
- **AI / Data Team**: Will isolate model inference prompts and implement authorization checks before user-specific records are supplied to the assistant context (AS-013)[cite: 1].