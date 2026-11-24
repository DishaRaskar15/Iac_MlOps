# Infrastructure as Code notes

- **Idempotency:** Terraform compares the declared configuration with its state and the actual managed resources. Reapplying an unchanged configuration should make no additional changes; local files are recreated only when their declared content or paths change.
- **Versioning:** Keep Terraform configuration and variable definitions in source control so infrastructure changes can be reviewed, traced, and rolled back. Do not commit credentials or sensitive state files.
- **Configuration drift:** Drift occurs when managed infrastructure changes outside Terraform. A new plan detects differences and proposes reconciliation; regularly review plans before applying them.

This exercise uses Terraform's `local` provider. Its bucket, registry, compute, and IAM resources are local file definitions for reproducibility and demonstration; they do not create cloud services or enforce cloud permissions.
