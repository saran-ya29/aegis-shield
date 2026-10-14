# Aegis Shield — Risk Register

- **Standard**: OWASP ASVS v4.0 / WSTG
- **Scoring**: Likelihood (1–5) × Impact (1–5). Bands: 1–6 Low, 7–12 Medium, 13–19 High, 20–25 Critical.
- **Review Cycle**: Phase 1 (Pre-implementation Design Review)

---

## Active Risk Register

| Risk ID | Asset | Threat Description | L | I | Pre-Score | Mitigation / Agreed Architecture | Post-Score | Status |
| :--- | :--- | :--- | :---: | :---: | :---: | :--- | :---: | :--- |
| **AS-001** | A1 (Passwords) | Fast password cracking via compromised DB backup due to SHA-256 hashing. | 3 | 5 | **15 (High)** | Upgrade hashing to Argon2id (ASVS §2.4) with memory cost 64MB and time cost 3. | 1 × 5 = **5 (Low)** | Mitigated in Design |
| **AS-002** | A1 (Credentials) | Credential stuffing and brute-force password guessing due to lack of rate limiting on login. | 5 | 4 | **20 (Critical)**| Implement Redis sliding-window rate limiting (10 req/min/IP) and account lockout after 5 failed attempts. | 2 × 3 = **6 (Low)** | Mitigated in Design |
| **AS-003** | A1 (Sessions) | Long session replay window if 24-hour access token is stolen via network or logs. | 4 | 4 | **16 (High)** | Reduce access token lifetime to 15 minutes; require short-lived rotation. | 2 × 3 = **6 (Low)** | Mitigated in Design |
| **AS-004** | A1 (Tokens) | Complete session hijacking via XSS token extraction from browser `localStorage`. | 4 | 5 | **20 (Critical)**| Store refresh tokens in `HttpOnly; Secure; SameSite=Strict` cookies with automatic token rotation. | 1 × 4 = **4 (Low)** | Mitigated in Design |
| **AS-005** | A1 (Sessions) | Inability to terminate active compromised sessions upon user logout. | 3 | 4 | **12 (Medium)**| Server-side session invalidation: delete refresh token and add access token `jti` to Redis blocklist. | 1 × 3 = **3 (Low)** | Mitigated in Design |
| **AS-006** | A3 (User Info) | User and employee email enumeration via differentiated error messages (`404` vs `401`). | 4 | 2 | **8 (Medium)** | Standardize on uniform error message (`"Invalid email or password"`) with constant-time response paths. | 1 × 2 = **2 (Low)** | Mitigated in Design |
| **AS-007** | A4 (Financials) | Privilege escalation and unauthorized payroll execution due to broad single `admin` role. | 3 | 5 | **15 (High)** | Split roles into segregated functional domains (`hr_admin`, `finance_admin`, `payroll_admin`). | 1 × 4 = **4 (Low)** | Mitigated in Design |
| **AS-008** | A1 (Tokens) | Account takeover via brute-forcing 6-digit password reset tokens without session invalidation. | 4 | 5 | **20 (Critical)**| 256-bit cryptographically secure URL-safe tokens, 15-minute expiry, and immediate invalidation of all active user sessions. | 1 × 4 = **4 (Low)** | Mitigated in Design |