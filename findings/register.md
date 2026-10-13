# Aegis Shield — STRIDE Risk Register

## Scoring Methodology
- **Formula**: Risk Score = Likelihood (1–5) × Impact (1–5)[cite: 1]
- **Severity Bands**: 1–6 Low, 7–12 Medium, 13–19 High, 20–25 Critical[cite: 1]

## Risk Register Table

| ID | STRIDE | Component / Flow | Threat Statement ("An attacker could... so that...") | Likelihood (1–5) | Impact (1–5) | Score | Band | Owner |
| :--- | :--- | :--- | :--- | :---: | :---: | :---: | :--- | :--- |
| **AS-001** | Spoofing | C2 Proxy / DF1 | An attacker could brute-force login credentials at the reverse proxy entry point so that unauthorized access to employee accounts is gained. | 4 | 4 | 16 | High | Identity |
| **AS-002** | Spoofing | C3 Portal / DF2 | An attacker could steal session cookies via cross-site scripting (XSS) so that they can impersonate active HR administrators. | 3 | 5 | 15 | High | Frontend |
| **AS-003** | Spoofing | C4 Backend / DF5 | An attacker could spoof client IP headers behind the reverse proxy so that IP-restricted payroll execution endpoints are bypassed. | 3 | 4 | 12 | Medium | Backend |
| **AS-004** | Tampering | TB2 / C3–C4 | An attacker with internal network access could sniff or modify unencrypted HTTP traffic between the proxy and backend so that financial transactions are altered in transit[cite: 1]. | 2 | 5 | 10 | Medium | Infra |
| **AS-005** | Tampering | C4 / DF5 | A malicious insider could tamper with ledger recalculation parameters directly in backend memory so that payroll balances are illicitly manipulated[cite: 1]. | 2 | 5 | 10 | Medium | Backend |
| **AS-006** | Tampering | C8 Redis / TB3 | An unauthenticated attacker reaching the Redis port could overwrite cached session objects so that privilege states are modified. | 3 | 4 | 12 | Medium | Platform |
| **AS-007** | Tampering | C7 Postgres / DF12 | An attacker compromising database volumes could manipulate snapshot backups so that disaster recovery restores corrupt financial ledger data. | 2 | 5 | 10 | Medium | Infra |
| **AS-008** | Repudiation | C4 / DF5 | A rogue payroll manager could execute an arbitrary off-cycle bonus run without transactional logging so that the transaction cannot be attributed[cite: 1]. | 3 | 5 | 15 | High | Backend |
| **AS-009** | Repudiation | C4 / DF6 | An approver could deny authorizing an inflated expense report if digital signatures or immutable logs are absent so that organizational accountability fails. | 3 | 3 | 9 | Medium | Finance |
| **AS-010** | Repudiation | C10 Monitoring | An attacker with access to logging nodes could clear or alter log files so that incident trace evidence is destroyed[cite: 1]. | 2 | 5 | 10 | Medium | Platform |
| **AS-011** | Info Disclosure | C4 / DF3 | An authenticated standard employee could manipulate employee IDs in REST endpoints (BOLA/IDOR) so that peers' bank account details and salary data are exposed[cite: 1]. | 5 | 5 | 25 | Critical | Backend |
| **AS-012** | Info Disclosure | C4 / DF4 | An attacker could alter URL parameters on payslip download endpoints so that other employees' payslip PDFs are leaked[cite: 1]. | 4 | 5 | 20 | Critical | Backend |
| **AS-013** | Info Disclosure | TB4 / C5 AI | An attacker could prompt-inject the AI chat assistant so that private employee PII or chat histories from other sessions are extracted[cite: 1]. | 4 | 4 | 16 | High | AI / ML |
| **AS-014** | Info Disclosure | C7 Postgres | An attacker accessing exposed database ports could dump tables so that all employee national IDs, dates of birth, and password hashes are stolen[cite: 1]. | 2 | 5 | 10 | Medium | Infra |
| **AS-015** | Info Disclosure | C10 / DF11 | Backend developers could log raw HTTP request payloads containing passwords or tokens so that credentials leak into centralized telemetry[cite: 1]. | 4 | 4 | 16 | High | Backend |
| **AS-016** | Info Disclosure | C11 Laptops | A developer could commit unencrypted production API keys or signing secrets to GitHub so that unauthorized third parties compromise infrastructure[cite: 1]. | 4 | 5 | 20 | Critical | Platform |
| **AS-017** | Denial of Service | C4 Backend / DF4 | An attacker could request thousands of PDF payslip renders concurrently so that backend CPU and memory are exhausted, causing service outages. | 4 | 3 | 12 | Medium | Backend |
| **AS-018** | Denial of Service | C5 AI / DF8 | An attacker could send massive feature payloads to the AI anomaly service so that model inference workers lock up and crash[cite: 1]. | 3 | 3 | 9 | Medium | AI / ML |
| **AS-019** | Denial of Service | C8 Redis | An unauthenticated client could flood the Redis queue with dummy worker jobs so that critical payroll processing background jobs are starved[cite: 1]. | 3 | 4 | 12 | Medium | Platform |
| **AS-020** | Denial of Service | C2 Proxy / TB1 | An attacker could launch an HTTP flood against the reverse proxy so that legitimate employees cannot access the workforce portal. | 4 | 3 | 12 | Medium | Infra |
| **AS-021** | Elevation of Priv | C4 / DF2 | An attacker could tamper with JWT claims or session roles so that a general employee elevates their rights to finance administrator[cite: 1]. | 4 | 5 | 20 | Critical | Backend |
| **AS-022** | Elevation of Priv | TB5 / C9 CI | An attacker could inject malicious build steps into the CI pipeline so that backdoored container images are deployed into the production cluster[cite: 1]. | 3 | 5 | 15 | High | Platform |
| **AS-023** | Elevation of Priv | C3 Portal | An attacker could exploit client-side route parameter validation to bypass portal route guards so that administrative views are displayed. | 3 | 3 | 9 | Medium | Frontend |
| **AS-024** | Elevation of Priv | C4 / DF6 | A user submitting an expense could manipulate the approver role parameter so that expenses are self-approved without managerial sign-off. | 4 | 4 | 16 | High | Backend |
| **AS-025** | Spoofing | TB5 / C9 Registry | An attacker could push an unverified image to the container registry under a trusted tag so that malicious code runs inside production pods. | 2 | 5 | 10 | Medium | Infra |
| **AS-026** | Tampering | TB4 / DF8 | An attacker could tamper with training or feature data sent to the attrition model so that prediction algorithms output biased outcomes[cite: 1]. | 2 | 3 | 6 | Low | AI / ML |
| **AS-027** | Repudiation | C3 Portal / DF1 | An employee could deny logging in or initiating transactions if session tracking lacks IP/User-Agent attribution in audit records[cite: 1]. | 3 | 2 | 6 | Low | Frontend |
| **AS-028** | Info Disclosure | C6 Analytics / DF9 | An attacker could manipulate iframe embed tokens so that internal company-wide productivity metrics are accessed without authorization[cite: 1]. | 3 | 3 | 9 | Medium | Analytics |
| **AS-029** | Denial of Service | C7 Postgres | An attacker could issue unindexed, complex search queries across employee records so that the primary database locks up. | 3 | 3 | 9 | Medium | Backend |
| **AS-030** | Elevation of Priv | C5 AI / DF7 | An attacker could trick the chat assistant via prompt injection into invoking administrative backend functions outside the user's role[cite: 1]. | 3 | 4 | 12 | Medium | AI / ML |