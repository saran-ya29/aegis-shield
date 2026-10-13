# Secure Coding Checklist — Python Backend (FastAPI / SQLAlchemy)

- [ ] **BOLA / IDOR Prevention:** Make sure database queries only return records that the logged-in user is allowed to access. Always check the user's tenant and permissions before returning data.

- [ ] **Schema Validation:** Use Pydantic schemas to validate incoming requests. Define the expected data types, required fields, and size limits.

- [ ] **SQL Injection Prevention:** Use SQLAlchemy ORM or parameterized queries. Never build SQL queries by directly joining user input with SQL strings.

- [ ] **JWT Verification:** Validate the JWT signature, issuer (`iss`), audience (`aud`), and expiration (`exp`) on every request. Use FastAPI dependencies, such as `Depends(get_current_user)`, to verify authenticated users.

- [ ] **Separation of Duties:** Check permissions on the server and prevent users from approving their own expenses, financial transactions, or role changes where independent approval is required.

- [ ] **Safe File Handling:** Check uploaded file types and sizes. Generate unique filenames on the server instead of trusting filenames supplied by users.

- [ ] **Sensitive Data Redaction:** Remove or mask passwords, tokens, secrets, authorization headers, and personal information before writing logs.

- [ ] **Audit Logging:** Record financial transactions and privilege changes in audit logs. Create the audit record within the same database transaction as the operation.

- [ ] **No Hardcoded Secrets:** Load database URLs, API keys, and signing keys from environment variables or secure configuration management using Pydantic `BaseSettings`.

- [ ] **Rate Limiting:** Limit requests to login, password reset, and sensitive file export endpoints to reduce abuse.

- [ ] **Safe Deserialization:** Use `json.loads` or Pydantic to process external data safely. Never use `pickle.loads` or `eval` on untrusted input.

- [ ] **Generic Error Responses:** Handle exceptions safely and return clear, generic error messages to users. Do not expose stack traces, database details, or internal implementation information.