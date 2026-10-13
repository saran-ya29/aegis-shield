# Secure Coding Checklist — Full Stack & Frontend (Next.js / TypeScript)

- [ ] **XSS Prevention:** Rely on React JSX automatic escaping; avoid using `dangerouslySetInnerHTML` unless input is passed through an approved sanitizer like DOMPurify.

- [ ] **Cookie Security:** Store session and authentication tokens in cookies marked `HttpOnly`, `Secure`, and `SameSite=Strict` (or `SameSite=Lax`).

- [ ] **No Exposed Secrets:** Never prefix sensitive API keys, signing secrets, or private tokens with `NEXT_PUBLIC_`.

- [ ] **Server-Side Route Guarding:** Enforce authentication and role permissions within Next.js middleware or server-side data fetchers (`getServerSideProps`), not solely in client-side component rendering.

- [ ] **Content Security Policy (CSP):** Configure HTTP response headers with a strict CSP restricting script execution to trusted origins and blocking inline scripts (`'unsafe-inline'`).

- [ ] **Form Input Validation:** Validate and sanitize form inputs using client-side schema libraries (Zod or Yup) before making API requests.

- [ ] **Clickjacking Protection:** Ensure headers include `X-Frame-Options: DENY` or CSP `frame-ancestors 'none'` to prevent embedding in malicious iframes.

- [ ] **Open Redirect Prevention:** Validate redirect targets against an approved internal route whitelist; never redirect users to arbitrary query-string URLs.

- [ ] **No Sensitive Data in Browser Storage:** Never persist JWTs, plaintext passwords, or employee PII inside `localStorage` or `sessionStorage`.

- [ ] **Safe URL Routing:** Avoid predictable or sequential resource identifiers in frontend URLs; route requests using non-sequential identifiers (such as UUIDs).

- [ ] **Dependency Auditing:** Run `npm audit` before submitting pull requests to ensure front-end dependencies contain no unresolved High or Critical vulnerabilities.