# Secure Coding Checklist — AI & ML Services

- [ ] **Prompt Boundary Isolation:** Separate trusted system instructions from untrusted user inputs using clear prompt delimiters and structured schemas.

- [ ] **Pre-Retrieval Authorization:** Verify user tenant and role permissions before querying vector databases or RAG stores; do not retrieve records the user is not authorized to see.

- [ ] **Output Sanitization & PII Scrubbing:** Filter model responses using regex or PII detection to prevent accidental exposure of compensation figures, national IDs, or credentials.

- [ ] **Function / Tool Invocation Safeguards:** Restrict LLM tool-calling to a strict whitelist of safe read operations; require human-in-the-loop authorization for any state-modifying actions.

- [ ] **Inference Rate & Token Caps:** Enforce character and token limits on incoming prompts to prevent resource exhaustion and denial-of-service (DoS) on inference servers.

- [ ] **Safe Model Deserialization:** Load model weights exclusively from safe serialization formats (such as Safetensors or ONNX); never deserialize unverified Python `pickle` files.

- [ ] **Secure API Key Management:** Retrieve model provider credentials (OpenAI, Anthropic, HuggingFace) from environment variables or a managed secrets store; never commit them to code.

- [ ] **System Prompt Protection:** Design system instructions to resist model inversion and jailbreak patterns (such as "ignore all previous instructions").

- [ ] **Training & Fine-Tuning Hygiene:** Ensure all datasets used for evaluation, fine-tuning, or few-shot examples are scrubbed of production secrets and employee personal data.

- [ ] **Audit Logging for AI Operations:** Record user prompt transactions, token counts, and requested tool executions with clear actor attribution in centralized telemetry.