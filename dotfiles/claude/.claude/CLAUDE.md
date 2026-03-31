# User-Level CLAUDE.md

Global conventions for the all projects. These rules apply across all 
repositories unless a project-level CLAUDE.md overrides them.

## Overview

I am a developer and I build applications, services for living. I primarily
build backend services using TypeScript and ALWAYS use Effect along with it.
I also use Google Cloud Platform to host my applications and use Firebase for
Auth, Firestore, FCM, etc.

## Git & Commits

All repos enforce **conventional commits** via `git-conventional-commits` +
pre-commit hooks.

> Refer to `git-commit` and `pre-commit` skills respectively

## Coding Standards

> Refer to project documentation and CLAUDE.md files

### Dart

> Refer to dart & flutter related skills

## TypeScript

> Refer to typescript related skills

## Infrastructure & Secrets

| Concern         | Tool                          |
| --------------- | ----------------------------- |
| Cloud           | Google Cloud Platform         |
| Compute         | Google Cloud Run              |
| Auth            | Firebase Authentication       |
| Database        | Firebase Firestore            |
| Secrets         | Doppler or fnox               |
| Observability   | OpenTelemetry → Grafana Cloud |
| Containers      | Docker (Chainguard images)    |
| CI/CD           | GitHub Actions + Cloud Build  |
| IaC             | Pulumi (TypeScript)           |
| Version Manager | Mise                          |
| Env Variables   | Mise                          |
| Tasks           | Mise                          |

## Testing

> Refer to project documentation, skills & CLAUDE.md files

## Documentation

> Refer to `documentation-writer` skill