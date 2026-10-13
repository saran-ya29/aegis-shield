# Aegis Shield — Secure Coding Standard and Security Requirements

## 1. Scope and Target ASVS Verification Level

WorkforceOS follows the **OWASP Application Security Verification Standard (ASVS v4.0.3)** to define its security requirements. Two verification levels are used based on the sensitivity of the application and its data.

### Target Levels

- **ASVS Level 1 – Baseline:** Applies to all application components, public endpoints, and internal services. It covers common security risks and provides a basic level of protection across the system.

- **ASVS Level 2 – Additional Security:** Applies to areas that handle sensitive information or important business operations, including:
  1. **Authentication and Identity:** Login, multi-factor authentication (MFA), password resets, and session or token validation.
  2. **Financial Operations:** Payroll calculations, bonus payments, bank account updates, and expense approvals.
  3. **Personal and Confidential Data:** Employee records, salary details, national identity numbers, and tax documents.

### Why These Levels Are Used

WorkforceOS handles sensitive employee information and financial operations, so stronger security controls are needed for critical areas.

ASVS Level 1 provides a common security baseline for all services. Level 2 adds further protection through server-side authorization, secure token validation, protected audit logs, and separation of duties.

These controls help reduce the risk of unauthorized data access, financial manipulation, and security compliance issues.

---

## 2. Security Requirements for the Top 10 Threats

The following requirements address the top 10 threats identified in Task 1. Each requirement must be tested and marked as either **PASS** or **FAIL**.

| Threat ID | Security Requirement | ASVS Reference | OWASP Cheat Sheet |
|---|---|---|---|
| **AS-011 – BOLA / IDOR on APIs** | Every API endpoint that accepts an employee ID, account ID, or other resource ID must check the user's permissions on the server before allowing access to that record. | V4.1.1, V4.1.3 | [Authorization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html), [Insecure Direct Object Reference Prevention](https://cheatsheetseries.owasp.org/cheatsheets/Insecure_Direct_Object_Reference_Prevention_Cheat_Sheet.html) |
| **AS-012 – Payslip URL Exposure** | Payslip and export downloads must require authentication and ownership checks. Alternatively, the system may use cryptographically signed download URLs that expire within five minutes. | V4.3.1, V12.3.1 | [File Inclusion Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/File_Inclusion_Cheat_Sheet.html), [Authorization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html) |
| **AS-016 – Hardcoded Secrets** | API keys, tokens, certificates, and database credentials must not be committed to source control. Secrets must be obtained securely at runtime from an approved secrets store or protected configuration mechanism. | V14.2.1, V14.2.3 | [Secrets Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html) |
| **AS-021 – JWT Tampering** | The application must validate JWT signatures using a trusted key and an approved algorithm. It must also verify the issuer (`iss`), audience (`aud`), and expiration (`exp`) and reject tokens using the `none` algorithm. | V3.5.2, V3.5.3 | [JSON Web Token Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/JSON_Web_Token_for_Java_Cheat_Sheet.html), [Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html) |
| **AS-001 – Login Brute-Force** | Login endpoints must allow no more than five failed attempts per username/IP combination within a rolling five-minute window. Responses must not reveal whether an account exists. | V2.2.1, V2.2.2 | [Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html), [Credential Stuffing Prevention](https://cheatsheetseries.owasp.org/cheatsheets/Credential_Stuffing_Prevention_Cheat_Sheet.html) |
| **AS-013 – AI Prompt Injection** | User input must be handled separately from trusted system instructions. The backend must check permissions before providing employee information to the AI assistant and prevent unauthorized data from being returned. | V5.1.1, V5.1.3 | [Input Validation Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html), [AI Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/AI_Security_Cheat_Sheet.html) |
| **AS-015 – Sensitive Data in Logs** | Logging middleware must remove or mask sensitive fields, including passwords, tokens, secrets, authorization headers, tax IDs, and bank account details, before logs are stored or transmitted. | V7.1.1, V7.1.2 | [Logging Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html) |
| **AS-024 – Expense Self-Approval** | The backend must reject expense approval requests when the approver and submitter are the same person. The request must return HTTP 403 Forbidden. | V4.1.5, V4.2.2 | [Authorization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html), [Transaction Authorization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Transaction_Authorization_Cheat_Sheet.html) |
| **AS-002 – XSS and Session Security** | Session cookies must use the `HttpOnly`, `Secure`, and `SameSite=Strict` attributes. The frontend must also use a Content Security Policy (CSP) to restrict untrusted scripts and unsafe inline execution. | V3.4.1, V3.4.2, V14.4.1 | [Session Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html), [Cross-Site Scripting Prevention](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html) |
| **AS-008 – Payroll Audit Records** | Every financial update and payroll operation must create an audit record containing the timestamp, operator ID, tenant ID, action, and payload hash. The audit record must be written as part of the same database transaction as the operation. | V7.2.1, V7.3.1 | [Logging Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html), [Transaction Authorization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Transaction_Authorization_Cheat_Sheet.html) |

---

## 3. Definition of Secure Done (DoSD)

A feature must meet the following security requirements before it can be marked as **Done** or merged into the `main` branch.

- [ ] **Threat Model Updated:** New endpoints, external services, and data stores are added to the architecture diagram and STRIDE risk register.

- [ ] **Input Validation:** Incoming requests are validated using Pydantic or Zod schemas before business logic is executed.

- [ ] **Server-Side Authorization:** Every endpoint verifies the user's identity, tenant access, and permissions for the requested resource.

- [ ] **No Hardcoded Secrets:** Gitleaks scans pass, and application secrets are loaded securely through approved configuration or secrets management.

- [ ] **Sensitive Data Redaction:** Logs do not expose passwords, authentication tokens, sensitive headers, or private employee information.

- [ ] **Automated Security Tests:** Unit and integration tests cover normal operations and unauthorized access attempts.

- [ ] **Security Scans Completed:** Bandit or Semgrep scans and pip-audit or npm audit checks show no unresolved High or Critical findings.

- [ ] **Audit Records Created:** Financial, identity, and HR operations that change system data produce protected audit records.

- [ ] **Code Review Completed:** At least one engineer reviews the pull request using the team's secure coding checklist before approval.

---

## 4. Implementation and Verification

The development team must implement the security requirements and test them before releasing the application.

Each requirement should have a corresponding test result:

- **PASS:** The security requirement has been implemented and verified through testing.
- **FAIL:** The requirement is missing, incomplete, or has failed its security test.

Failed requirements must be addressed before the affected feature is approved for release.