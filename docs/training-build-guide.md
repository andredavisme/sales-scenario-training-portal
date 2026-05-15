# Sales Scenario Training Portal — Project Training Manual

> This manual covers what is unique to this repo.
> All global standards live in andredavisme/warrior-x-docs/operations/training-manual.md.

## What This Repo Is
A browser-based sales scenario training portal for industrial electrical distribution. Sales reps work through multiple-choice scenarios covering drives, circuit breakers, power supplies, motor starters, and industrial controls. The portal is built on Supabase (Postgres + RLS) with a static HTML/CSS/JS frontend.

## Who It Serves
Meridian Electric sales team members learning to identify, spec, and sell industrial electrical products. Designed for reps with no prior technical background.

## Tech Stack
- **Database:** Supabase (Postgres)
- **Auth:** TBD — anon key for open access or Supabase Auth for tracked progress
- **Frontend:** Static HTML/CSS/JS (no build tools required)
- **Hosting:** TBD — GitHub Pages or Supabase hosting
- **Migrations:** Sequential SQL files in `supabase/migrations/`

## Migration Naming Convention
`YYYYMMDD_NNN_description.sql` — never edit a migration once applied to production.

## Scenario Data Model
```sql
CREATE TABLE public.scenarios (
  id          uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  module      text NOT NULL,  -- 'drives' | 'breakers' | 'power_supplies' | 'starters' | 'controls'
  prompt      text NOT NULL,
  choices     jsonb NOT NULL, -- [{"label": "A", "text": "..."}]
  answer      text NOT NULL,  -- single letter: 'A' | 'B' | 'C' | 'D'
  explanation text NOT NULL,
  difficulty  text NOT NULL,  -- 'easy' | 'medium' | 'hard'
  created_at  timestamptz DEFAULT now()
);
```

## Scenario Count (as of 2026-05-15)
| Module | Count |
|---|---|
| Drives | 5 |
| Breakers | 14 |
| Power Supplies | 13 |
| Starters | 13 |
| Controls | 13 |
| **Total** | **58** |

## Key Conventions
- RLS is enabled on every table — no exceptions
- The `anon` role may SELECT from `scenarios` (read-only public access)
- No service role key in frontend code — ever
- All secrets go in the Supabase Vault
- Branch → commit → push → PR → review → merge. No direct commits to main.

## How to Contribute
1. Branch from main: `schema/description` for migrations, `feat/description` for frontend, `docs/description` for docs
2. Write or update the relevant migration in `supabase/migrations/`
3. Apply to Supabase via MCP before opening the PR
4. Open PR with a table summarizing new content
5. André reviews and merges

## Security Rules
- 🔴 Never put client or customer names in the repo name, filenames, or commit messages — use generic names only
- 🔴 RLS must be enabled on every table
- 🔴 Never use the service role key in frontend code
- 🔴 No API keys, passwords, or secrets in GitHub — Supabase Vault only

## Section 8: Sandbox Environment Notes

### Known Failure Modes
| Error | Cause | Fix |
|---|---|---|
| `/home/user/training-portal/index.html: No such file or directory` | `~` resolves to `/home/user/` which doesn't exist in the sandbox | Run `echo $HOME && pwd` first to confirm writable path |
| `mkdir: cannot create directory '/root': Permission denied` | Sandbox user has no write access to `/root` | Never hardcode `/root` — always confirm path with `pwd` |

### Rule: Always Confirm the Writable Path First
Before any file-writing session in the sandbox, run:
```bash
echo $HOME && pwd
```
This confirms the actual writable directory before any `mkdir` or file creation commands.

## Chapter 15 — Post-Mortems & Lessons Learned

### PM-001 — Sandbox Path Resolution Failure (2026-05-15)
**What happened:** File generation failed during initial build session. Two errors: (1) `~/training-portal/` path didn't exist because `~` resolved to a non-existent `/home/user/`; (2) retry with `/root/` was permission-denied.
**Root cause:** Sandbox filesystem doesn't follow standard Linux home directory layout. Writable path must be confirmed before any file write operations.
**Fix:** Start every file-writing session with `echo $HOME && pwd`.
**Rule added:** Section 8 of this manual + Chapter 9 of warrior-x-docs training manual.

### PM-002 — Repo Named After Client (2026-05-15)
**What happened:** Repo was initially created as `eia-schneider-training-portal`, directly naming the client in the public GitHub URL.
**Root cause:** No naming rule existed at time of repo creation.
**Fix:** Renamed to `sales-scenario-training-portal`.
**Rule added:** 🔴 Security Rule in this manual + propagated to warrior-x-docs Ch. 7, 9, 10, and 15.
