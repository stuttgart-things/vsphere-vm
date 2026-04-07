# CI/CD

## Pipeline Overview

```
Push / PR
  │
  ├── Validate ─── terraform validate
  │
  ├── Docs ─────── terraform-docs
  │
  └── Security ─── tfsec (HIGH, CRITICAL)
```

## Workflows

| Workflow | Trigger | Description |
|----------|---------|-------------|
| `validate-terraform.yaml` | push to feature/fix/renovate branches, PRs | Validate, docs, and security checks |
| `release-terraform.yaml` | manual dispatch | Validate and create GitHub release |
| `pages.yaml` | manual dispatch or release completion | Deploy MkDocs to GitHub Pages |

All jobs use reusable workflows from [stuttgart-things/github-workflow-templates](https://github.com/stuttgart-things/github-workflow-templates).

## Validation Jobs

| Job | Tool | Version | Description |
|-----|------|---------|-------------|
| Terraform-Validate | terraform | 1.10.5 | `terraform init` + `terraform validate` |
| Terraform-Docs | terraform-docs | - | Generate and verify documentation |
| Terraform-Security | tfsec | - | Scan for HIGH and CRITICAL severity issues |

## Release Process

Releases are triggered manually via `workflow_dispatch` with:

- `release-tag` — semantic version tag (e.g. `v2.12.0`)
- `release-message` — release description

The release workflow validates first, then creates a GitHub release with the module archive.

## Pre-commit Hooks

Local checks configured in `.pre-commit-config.yaml`:

| Hook | Purpose |
|------|---------|
| `trailing-whitespace` | Remove trailing whitespace |
| `end-of-file-fixer` | Ensure files end with newline |
| `check-added-large-files` | Prevent large file commits |
| `check-merge-conflict` | Detect merge conflict markers |
| `check-yaml` | Validate YAML syntax |
| `detect-private-key` | Detect accidentally committed keys |
| `detect-secrets` | High-entropy password detection |
| `shellcheck` | Shell script linting |
| `check-github-workflows` | Validate GitHub Actions schema |
