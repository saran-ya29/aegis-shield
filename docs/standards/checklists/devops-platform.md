# Secure Coding Checklist — DevOps & Platform Infrastructure

- [ ] **Automated Secret Detection:** Configure CI pipeline checks (such as Gitleaks or Trufflehog) to block any commits or pull requests containing plaintext credentials or tokens.

- [ ] **Run Containers as Non-Root:** Ensure every Dockerfile creates and switches to a dedicated unprivileged runtime user (`USER appuser`).

- [ ] **Hardened & Minimal Base Images:** Use minimal base images (such as `python:3.12-slim`, Alpine, or distroless) and keep package manager caches purged.

- [ ] **Container & Dependency Scanning:** Run automated vulnerability scanning (Trivy, Grype, or pip-audit) in CI pipelines; block builds with unpatched High or Critical CVEs.

- [ ] **Network Segmentation:** Restrict internal service communication so databases (ports 5432 and 6379) are reachable only from designated backend application containers.

- [ ] **TLS Enforcement & HSTS:** Terminate TLS (minimum TLS 1.2, preferred TLS 1.3) at the reverse proxy and configure HTTP Strict Transport Security (`Strict-Transport-Security`) headers.

- [ ] **Strict Environment Separation:** Keep development, staging, and production environments isolated; ensure staging never connects to production databases or utilizes live credentials.

- [ ] **Branch Protection Rules:** Require pull request code reviews and passing automated security checks on `main` before code can be merged.

- [ ] **Immutable Container Images:** Deploy container images pinned to specific commit SHAs or cryptographic image digests rather than mutable tags like `latest`.

- [ ] **Edge Rate Limiting & DoS Defense:** Configure rate limiting and request buffering at the reverse proxy entry point to mitigate denial-of-service attempts.

- [ ] **Tamper-Resistant Telemetry:** Stream container logs and audit records to centralized, append-only logging storage that cannot be modified by application runtime containers.