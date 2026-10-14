# Engineering Handoff: Authentication Specifications for Full Stack Team

- **To**: Full Stack Engineering Team (`C3 Next.js Portal`)
- **From**: Cyber Security Team (Aegis Shield)
- **Subject**: Agreed Security Constraints & API Contract for Authentication UI/UX (Task 4 Outcomes)

---

## Key Takeaways for Frontend Developers

The backend authentication contract (`C4 FastAPI`) has been updated following the Task 4 security review. Please implement the Next.js portal UI according to these constraints:

### 1. Token Storage & Cookie Handling
* **No Tokens in `localStorage`**: Never save access tokens or refresh tokens in `localStorage` or `sessionStorage` (mitigates XSS exfiltration).
* **Automatic Cookie Handling**: The backend now issues the `refresh_token` as an `HttpOnly; Secure; SameSite=Strict` cookie. The browser will automatically attach this cookie on calls to `/api/v1/auth/refresh` and `/api/v1/auth/logout`.
* **In-Memory Access Tokens**: Keep the short-lived 15-minute `access_token` in React component memory or a scoped state store.

### 2. Login Screen Error Display
* **Uniform Error Message**: When `POST /auth/login` returns a `401 Unauthorized`, always display:
  > *"Invalid email or password."*
* Never display user-specific hints such as *"Email not registered"* or *"Password incorrect"*.

### 3. Automatic Silent Token Refresh
* Because access tokens expire in 15 minutes, set an in-memory Axios / Fetch interceptor that triggers `POST /auth/refresh` at the 14-minute mark or on receiving a `401` response.
* If the refresh endpoint returns `401` (expired or reused token), clear local state and redirect the user to `/login`.

### 4. Logout Implementation
* The logout button must make an explicit `POST /api/v1/auth/logout` call to allow the backend to revoke the session server-side before redirecting to `/login`.

### 5. MFA / Step-Up Readiness
* The login response may return:
  ```json
  {
    "mfa_required": true,
    "mfa_ticket": "mfa_temp_token_abc123"
  }