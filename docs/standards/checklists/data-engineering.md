# Secure Coding Checklist — Data & Storage (PostgreSQL / Redis)

- [ ] **Least Privilege Database Roles:** Ensure application services connect using dedicated database roles limited to necessary tables and actions (never use the database `superuser` or root role).

- [ ] **Multi-Tenant Data Isolation:** Enforce tenant isolation in queries using tenant ID filters or PostgreSQL Row-Level Security (RLS) policies to prevent cross-tenant leakage.

- [ ] **Connection Encryption in Transit:** Enforce TLS/SSL for all PostgreSQL (`sslmode=verify-full` or `verify-ca`) and Redis client connections.

- [ ] **Redis Access Control & Network Binding:** Protect Redis with strong password authentication (`requirepass`) and bind the service strictly to internal private network interfaces.

- [ ] **Column-Level Encryption at Rest:** Encrypt sensitive fields (such as employee bank account numbers and tax IDs) using AES-GCM or `pgcrypto` before storing them on disk.

- [ ] **Safe Schema Migrations:** Review database migration scripts (Alembic/Flyway) to ensure schema modifications do not drop security constraints, expose unencrypted columns, or lock tables unexpectedly.

- [ ] **Encrypted Backups & Snapshots:** Ensure automated database dumps and snapshot volumes are encrypted at rest using managed encryption keys (KMS).

- [ ] **Data Retention & TTL Purging:** Apply automated Time-To-Live (TTL) expiration or scheduled purge routines for transient cache records, background queue jobs, and expired tokens.

- [ ] **Audit Log Immutability:** Set write-only / append-only permissions on audit log tables (`REVOKE UPDATE, DELETE ON audit_logs`) so existing activity records cannot be altered or removed.

- [ ] **Statement Timeouts & Query Limits:** Configure statement timeout limits on read and reporting queries to protect database resources from denial-of-service (DoS) conditions.