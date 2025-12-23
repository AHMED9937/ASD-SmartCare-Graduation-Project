# Git History Rebuild Guide

This guide provides instructions for rebuilding the repository's commit history to create a clean, milestone-based project history while removing old commits.

> [!CAUTION]
> **This operation is DESTRUCTIVE and IRREVERSIBLE.**
> - All existing commits will be removed from the repository
> - Collaborators with existing clones will need to re-clone or hard reset
> - GitHub PRs/issues referencing old commit SHAs will break
> - Backup everything before proceeding

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Milestone Commits Plan](#milestone-commits-plan)
- [Step-by-Step Rebuild Process](#step-by-step-rebuild-process)
- [Conventional Commits Standard](#conventional-commits-standard)
- [Post-Rebuild Checklist](#post-rebuild-checklist)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before starting:

1. **Ensure working directory is clean:**
   ```bash
   git status  # Should show "nothing to commit"
   ```

2. **Have all files locally:**
   ```bash
   git pull origin main
   ```

3. **Communicate with collaborators:**
   - Warn all team members about the upcoming history rewrite
   - Agree on a time when no one is actively working

4. **Backup everything:**
   ```bash
   # Create a backup branch
   git branch backup-main main
   
   # Create a backup tag
   git tag backup-before-rewrite
   
   # Optional: Create a full local backup
   cp -r . ../ASD-SmartCare-Backup
   ```

---

## Milestone Commits Plan

The following 13 milestone commits represent logical development phases:

| # | Commit Message | Files/Areas Included |
|---|----------------|---------------------|
| 1 | `feat: initialize Flutter project structure` | `pubspec.yaml`, `lib/main.dart`, platform folders (`android/`, `ios/`, etc.), `.gitignore`, `analysis_options.yaml` |
| 2 | `feat: add core infrastructure (network, cache, DI)` | `lib/core/network/`, `lib/core/cache/`, `lib/core/di/`, `lib/core/utils/`, `lib/core/errors/`, `lib/core/models/` |
| 3 | `feat: add design system (tokens, theme, shared UI)` | `lib/core/design_system/`, `lib/core/ui/`, `lib/core/state/` |
| 4 | `feat: implement authentication flow` | `lib/shared/auth/` (login, signup, password reset), `lib/app/router/` |
| 5 | `feat: add parent home and navigation` | `lib/parent/home/`, `lib/parent/navigation/` |
| 6 | `feat: add doctor home and navigation` | `lib/doctor/home/`, `lib/doctor/navigation/` |
| 7 | `feat: implement booking flow with payments` | `lib/parent/find_doctors/` (browse, details, booking), Stripe integration |
| 8 | `feat: add chatbot and AI screening` | `lib/parent/chatbot/`, `lib/parent/screening/` |
| 9 | `feat: add progress tracking and sessions` | `lib/parent/progress/`, `lib/parent/my_children/`, `lib/doctor/sessions/`, `lib/doctor/my_patients/` |
| 10 | `feat: add remaining features` | `lib/parent/account/`, `lib/parent/education/`, `lib/doctor/account/`, `lib/doctor/clinic/`, `lib/doctor/appointments/`, `lib/shared/donations/`, `lib/shared/medicines/` |
| 11 | `test: add comprehensive unit and widget tests` | All files in `test/` directory |
| 12 | `ci: configure GitHub Actions workflow` | `.github/workflows/`, badge additions |
| 13 | `docs: complete documentation` | `README.md`, `CONTRIBUTING.md`, `DEPLOYMENT.md`, `docs/` |

---

## Step-by-Step Rebuild Process

### Step 1: Create Backup (Critical!)

```bash
# Create backup branch and tag
git checkout main
git pull origin main
git branch backup-main
git tag backup-$(date +%Y%m%d) -m "Backup before history rewrite"

# Push backup to remote
git push origin backup-main
git push origin backup-$(date +%Y%m%d)

echo "✅ Backup created: branch 'backup-main' and tag 'backup-$(date +%Y%m%d)'"
```

### Step 2: Create Orphan Branch

```bash
# Create a new branch with no history
git checkout --orphan new-main

# Unstage all files (they remain in working directory)
git reset

# Verify working directory has all files
ls -la lib/

echo "✅ Orphan branch 'new-main' created"
```

### Step 3: Create Milestone Commits

For each milestone, stage the appropriate files and commit:

```bash
# =============================================================================
# Milestone 1: Initialize Flutter project structure
# =============================================================================
git add pubspec.yaml pubspec.lock analysis_options.yaml .gitignore
git add android/ ios/ linux/ macos/ web/ windows/
git add lib/main.dart
git add lib/appassets/
git add LICENSE

git commit -m "feat: initialize Flutter project structure

- Set up Flutter 3.32.x with multi-platform support
- Configure pubspec.yaml with core dependencies
- Add analysis_options.yaml with lint rules
- Set up .gitignore for Flutter project
"

# =============================================================================
# Milestone 2: Add core infrastructure
# =============================================================================
git add lib/core/network/
git add lib/core/cache/
git add lib/core/di/
git add lib/core/utils/
git add lib/core/errors/
git add lib/core/models/

git commit -m "feat: add core infrastructure (network, cache, DI)

- Implement Dio HTTP client with interceptors
- Add API constants and error handling
- Set up SharedPreferences cache helper
- Add dependency injection setup
"

# =============================================================================
# Milestone 3: Add design system
# =============================================================================
git add lib/core/design_system/
git add lib/core/ui/
git add lib/core/state/

git commit -m "feat: add design system (tokens, theme, shared UI)

- Create color, typography, spacing, and radius tokens
- Implement AppTheme consuming all tokens
- Add shared UI components (buttons, cards, states)
- Set up app-level Cubit and BLoC observer
"

# =============================================================================
# Milestone 4: Implement authentication
# =============================================================================
git add lib/shared/auth/
git add lib/app/router/

git commit -m "feat: implement authentication flow

- Add login screen with validation
- Add parent and doctor signup flows
- Implement password reset flow
- Set up centralized app router
"

# =============================================================================
# Milestone 5: Add parent home and navigation
# =============================================================================
git add lib/parent/home/
git add lib/parent/navigation/

git commit -m "feat: add parent home and navigation

- Create parent home screen with dashboard
- Implement bottom navigation
- Add greeting and care pulse widgets
"

# =============================================================================
# Milestone 6: Add doctor home and navigation
# =============================================================================
git add lib/doctor/home/
git add lib/doctor/navigation/

git commit -m "feat: add doctor home and navigation

- Create doctor dashboard with stats
- Implement bottom navigation
- Add quick action cards
"

# =============================================================================
# Milestone 7: Implement booking flow
# =============================================================================
git add lib/parent/find_doctors/

git commit -m "feat: implement booking flow with payments

- Add doctor browse and search
- Create doctor details screen
- Implement booking with Stripe payments
- Add confirmation and payment screens
"

# =============================================================================
# Milestone 8: Add chatbot and screening
# =============================================================================
git add lib/parent/chatbot/
git add lib/parent/screening/

git commit -m "feat: add chatbot and AI screening

- Implement autism chatbot with NLP
- Add Q&A screening test flow
- Create test history view
- Add autism level assessment
"

# =============================================================================
# Milestone 9: Add progress tracking
# =============================================================================
git add lib/parent/progress/
git add lib/parent/my_children/
git add lib/doctor/sessions/
git add lib/doctor/my_patients/

git commit -m "feat: add progress tracking and sessions

- Parent: progress dashboard and children management
- Doctor: session management and patient list
- Add session feedback and reviews
"

# =============================================================================
# Milestone 10: Add remaining features
# =============================================================================
git add lib/parent/account/
git add lib/parent/education/
git add lib/doctor/account/
git add lib/doctor/clinic/
git add lib/doctor/appointments/
git add lib/shared/donations/
git add lib/shared/medicines/
git add lib/app/

git commit -m "feat: add remaining features

- Profile management for parents and doctors
- Educational articles section
- Clinic availability management
- Appointment management
- Charity donations section
- Medicine guide
"

# =============================================================================
# Milestone 11: Add tests
# =============================================================================
git add test/

git commit -m "test: add comprehensive unit and widget tests

- Unit tests for Cubits/BLoCs
- Widget tests for screens
- Repository tests with mocks
- 69+ test files covering all features
"

# =============================================================================
# Milestone 12: Configure CI/CD
# =============================================================================
git add .github/

git commit -m "ci: configure GitHub Actions workflow

- Format and lint checks
- Test execution with coverage
- Android and web build verification
- Firebase App Distribution deployment
"

# =============================================================================
# Milestone 13: Complete documentation
# =============================================================================
git add README.md CONTRIBUTING.md DEPLOYMENT.md
git add docs/
git add .env.example
git add Dockerfile .dockerignore
git add specs/ devtools_options.yaml

git commit -m "docs: complete documentation

- Full README with all sections
- Contributing guidelines
- Deployment documentation
- Architecture diagrams
- Docker configuration
"

echo "✅ All milestone commits created"
```

### Step 4: Verify History

```bash
# View the new commit history
git log --oneline

# Should show 13 commits with clean messages
```

### Step 5: Replace Main Branch

```bash
# Delete old local main branch
git branch -D main

# Rename new-main to main
git branch -m main

echo "✅ Local main branch replaced"
```

### Step 6: Force Push to GitHub

> [!WARNING]
> This will overwrite the remote history. Ensure all collaborators are aware!

```bash
# Force push to overwrite remote
git push origin main --force

echo "✅ Remote main branch updated"
```

### Step 7: Clean Up

```bash
# Optionally delete backup branch from remote (keep for safety period)
# git push origin --delete backup-main

# Verify remote has new history
git log origin/main --oneline
```

---

## Conventional Commits Standard

All future commits must follow [Conventional Commits](https://www.conventionalcommits.org/):

### Format

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types

| Type | When to Use | Example |
|------|-------------|---------|
| `feat` | New feature | `feat(auth): add biometric login` |
| `fix` | Bug fix | `fix(booking): resolve payment timeout` |
| `docs` | Documentation | `docs: update API examples` |
| `style` | Formatting only | `style: fix indentation` |
| `refactor` | Code restructure | `refactor(home): extract widgets` |
| `test` | Tests | `test(chatbot): add edge cases` |
| `ci` | CI/CD changes | `ci: add coverage upload` |
| `build` | Build/deps | `build: upgrade flutter_bloc` |
| `chore` | Maintenance | `chore: update .gitignore` |

### Good vs Bad Examples

✅ **Good:**
```
feat(screening): add voice input for Q&A test

Allows parents to answer screening questions via voice,
improving accessibility for users with limited mobility.

Closes #42
```

❌ **Bad:**
```
fixed stuff
update code
WIP
asdf
```

### Atomic Commits

Each commit should:
- Focus on ONE logical change
- Be "PR-sized" (reviewable in ~15 min)
- Build successfully
- Pass all tests

---

## Post-Rebuild Checklist

After rebuilding history:

- [ ] Verify all files are present in latest commit
- [ ] Run `flutter pub get` successfully
- [ ] Run `flutter analyze` with no errors
- [ ] Run `flutter test` with all tests passing
- [ ] Verify CI pipeline runs successfully
- [ ] Update PR base branches if any open PRs
- [ ] Notify all collaborators to re-clone

---

## Troubleshooting

### "Files missing after orphan checkout"

Files are unstaged, not deleted. Check with:
```bash
git status
ls -la lib/
```

### "Push rejected"

You need `--force` for history rewrites:
```bash
git push origin main --force
```

### "Want to undo the rewrite"

Restore from backup:
```bash
git checkout backup-main
git branch -D main
git branch -m main
git push origin main --force
```

### "Collaborator has diverged history"

They must reset or re-clone:
```bash
# Option 1: Reset
git fetch origin
git reset --hard origin/main

# Option 2: Re-clone
cd ..
rm -rf ASD-SmartCare-Graduation-Project
git clone <repo-url>
```

---

## Summary

1. **Backup first** (branch + tag)
2. **Create orphan branch** (clean slate)
3. **Commit in milestones** (logical progression)
4. **Force push** (replace remote history)
5. **Use Conventional Commits** (going forward)
