# User-Level CLAUDE.md

Global conventions for the all projects. These rules apply across all
repositories unless a project-level CLAUDE.md overrides them.

## Overview

I am a developer and I build applications, services for living. I primarily
build backend services using TypeScript and ALWAYS use Effect along with it. I
also use Google Cloud Platform to host my applications and use Firebase for
Auth, Firestore, FCM, etc.

## Git & Commits

All repos enforce **conventional commits** via `git-conventional-commits` +
pre-commit hooks.

> Refer to `git-commit` and `pre-commit` skills respectively NEVER commit
> directly to `main` & `develop` branches. Always use feature branches.
