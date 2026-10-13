# Architecture Notes and Asset Inventory

## 1. System Components

The project consists of the following components:

- **C1 – Browser:** The web interface used by employees, HR staff, and finance administrators.
- **C2 – Reverse Proxy:** Uses Nginx or Envoy to handle HTTPS traffic and forward requests to the appropriate services.
- **C3 – Portal:** A Next.js application running on port 3000. It manages user-facing pages and authentication cookies.
- **C4 – Backend API:** A FastAPI service running on port 8000. It handles authentication, leave requests, payslips, payroll, and financial transactions.
- **C5 – AI Service:** A Python service running on port 8100. It supports the AI assistant and machine learning tasks, such as attrition prediction and anomaly detection.
- **C6 – Analytics Service:** Runs on port 8200 and provides reporting features through embedded dashboards.
- **C7 – PostgreSQL:** Stores user details, employee records, payroll information, and financial transactions.
- **C8 – Redis:** Handles caching and supports background tasks and message queues.
- **C9 – CI/CD and Registry:** Builds application images, runs security scans, and manages software releases and deployments.
- **C10 – Monitoring and Logging:** Collects application logs, system metrics, and other monitoring data.
- **C11 – Developer Workstations:** Includes developers' laptops, coding tools, and GitHub repositories used to manage the source code.

## 2. Data Assets and Classification

The system handles different types of data, each with its own level of sensitivity.

### Secret

- **A1:** Passwords, session cookies, and authentication tokens.
- **A7:** Application signing keys, database encryption keys, and external API credentials.

### Restricted

- **A2:** Employee salaries, bank details, and national identity numbers.
- **A4:** Financial transactions, payroll records, invoices, and expense details.

### Confidential

- **A3:** Employee personal information, including names, contact details, and dates of birth.
- **A6:** AI model weights, prompts, and user chat history.
- **A8:** Source code, Dockerfiles, and pipeline configuration files.

### Integrity-Critical

- **A5:** Audit logs and system event history that must remain accurate and protected from unauthorized changes.

## 3. Trust Boundaries

Trust boundaries separate different parts of the system where security checks are needed.

- **TB1 – Internet to Proxy:** Handles incoming requests from the public internet, which is considered untrusted.
- **TB2 – Proxy to Applications:** Covers communication between the reverse proxy and the Next.js and FastAPI services. Internal traffic is currently described as plaintext.
- **TB3 – Applications to Storage:** Covers database queries and access to Redis from the application services.
- **TB4 – Backend to AI and Analytics:** Covers the transfer of employee and payroll data from the backend to the AI and analytics services.
- **TB5 – Development to Production:** Covers the movement of source code and build artifacts from developer systems and CI/CD pipelines into production.

## 4. Main Data Flows

The following data flows describe how information moves through the system.

- **DF1 – Login:** The browser sends login requests through the proxy and portal to the backend API, which handles authentication and session creation.
- **DF2 – Session Verification:** The application checks session cookies or authentication tokens when users access protected API endpoints.
- **DF3 – Employee Records:** The backend retrieves employee information based on the user's assigned role and permissions.
- **DF4 – Payslip Retrieval:** Employees request their payslips, and the system retrieves the relevant records and generates PDF files when needed.
- **DF5 – Payroll Processing:** Administrators run payroll, update financial records, generate payslips, and create audit entries.
- **DF6 – Expense and Invoice Approval:** Users submit expenses and invoices for review and approval.
- **DF7 – AI Assistant:** The AI assistant processes user queries and accesses employee information permitted for that user.
- **DF8 – ML Predictions:** The AI service processes requests for anomaly detection and employee attrition prediction.
- **DF9 – Analytics Dashboard:** The application embeds analytics dashboards using signed tokens to control access.
- **DF10 – CI/CD Pipeline:** The pipeline builds the application, scans container images for security issues, and deploys approved releases.
- **DF11 – Monitoring:** Application logs and performance metrics are collected by the central monitoring system.
- **DF12 – Database Backups:** Database snapshots are exported to backup storage for recovery purposes.