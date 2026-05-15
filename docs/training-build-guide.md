# Sales Scenario Training Portal — Training Build Guide

> This guide documents how the portal is structured, how content is seeded, and how to extend it.
> All global Warrior X standards live in `andredavisme/warrior-x-docs/operations/training-manual.md`.

---

## Section 1: Project Overview

This portal teaches sales professionals to handle realistic customer scenarios for industrial electrical products. It uses a question-and-answer mechanic with instant feedback.

- **Mock company:** Meridian Industrial Supply
- **Mock product line:** VoltEdge (VFDs, breakers, power supplies, starters, controls)
- **All names are fictitious** — no real brands, no real client names anywhere in the codebase or repo URL

---

## Section 2: Repository Structure

```
sales-scenario-training-portal/
├── README.md
├── docs/
│   ├── progress.md          ← Session log and milestone tracker
│   └── training-build-guide.md  ← This file
└── supabase/
    └── migrations/          ← TO BE CREATED (see OD-001)
        └── YYYYMMDD_NNN_description.sql
```

---

## Section 3: Supabase Schema

### `scenarios` table

| Column | Type | Notes |
|---|---|---|
| `id` | uuid | Primary key, default gen_random_uuid() |
| `module` | text | One of: drives, breakers, power_supplies, starters, controls |
| `prompt` | text | The customer scenario text |
| `choices` | jsonb | Array of {label, text} objects |
| `answer` | text | Correct answer label (e.g. "B") |
| `explanation` | text | Why the answer is correct |
| `difficulty` | text | easy / medium / hard |
| `created_at` | timestamptz | Default now() |

- RLS enabled with a public read-only policy
- Index on `module` for fast filtering by training module

---

## Section 4: Seed Content — Current State

### Applied to Supabase (Session 1)

18 scenarios seeded directly via Supabase MCP tool across all 5 modules:

| Module | Count | Topics |
|---|---|---|
| `drives` | 5 | VFD selection, torque control, energy savings, enclosure ratings, fault diagnosis |
| `breakers` | 4 | Breaker selection, crossover criteria, motor protection sizing, full panels |
| `power_supplies` | 3 | 24VDC sizing, temperature derating, DIN-rail form factor |
| `starters` | 3 | FVNR with overload, reversing starter, soft starter benefits |
| `controls` | 3 | 3-wire control circuit, pilot light wiring, E-stop requirements |

> ⚠️ These seeds are **not yet version-controlled** in `supabase/migrations/`. See OD-001.

### Designed but not yet applied (Session 4)

Module 2 extended seed — Circuit Breakers deep dive:

| Lesson | Exercise 1 | Exercise 2 | Points |
|---|---|---|---|
| Breaker Fundamentals | AIC rating explained | Thermal-mag vs electronic trip | 10 + 10 |
| Breaker Sizing — NEC | Motor branch circuit 250% rule | Continuous load 125% rule | 10 + 10 |
| MCCB vs MCB vs GFCI/AFCI | 150A 480V feeder selection | Garage GFCI solution | 10 + 10 |
| Scenario: Panel Upgrade | AIC mismatch after transformer upgrade | Continuous load upsell | 15 + 15 |
| Scenario: Motor Branch Circuit | 25HP breaker sizing | Breaker as disconnect (NEC 430.109) | 15 + 15 |

Status: **Pending OD-001 resolution before applying.**

---

## Section 5: Open Decision — OD-001

**Where do SQL seed files live?**

The repo currently has no `supabase/migrations/` directory. Seeds from Session 1 were applied directly to the Supabase project and are not reproducible from the repo alone.

**Options:**

| Option | Approach | Trade-off |
|---|---|---|
| A (recommended) | Apply via MCP + push `.sql` to `supabase/migrations/` | Best practice, fully reproducible |
| B | Supabase direct only, no SQL files in repo | Fast, but seeds lost if project is deleted |
| C | Push SQL files, André applies manually | Good for CI/CD pipeline, more steps |

**Resolve before Session 5.**

---

## Section 6: Migration Naming Convention

Follow the Warrior X standard:

```
YYYYMMDD_NNN_description.sql
```

Examples:
```
20260515_001_create_scenarios_table.sql
20260515_002_seed_module_drives.sql
20260515_003_seed_module_breakers.sql
20260515_004_seed_module_2_extended_breakers.sql
```

- Never edit a migration file once it has been applied to production
- Always include a rollback comment at the bottom (even if not automated)

---

## Section 7: Anonymization Rules

- **Never use real client names in the repo URL, file names, or commit messages**
- Repo name must be generic and descriptive (e.g., `sales-scenario-training-portal`)
- All scenario content uses fictitious company names and product names
- GitHub is public — treat every file as potentially visible to anyone
- Real client details (if any) go in a private Supabase Vault secret only

---

## Section 8: Sandbox Environment Notes

### Known Failure Modes

| Error | Cause | Fix |
|---|---|---|
| `/home/user/file.html: No such file or directory` | `~` resolves to `/home/user/` which doesn't exist in this sandbox | Run `echo $HOME && pwd` first to confirm actual writable path |
| `mkdir: cannot create directory '/root': Permission denied` | Sandbox user has no write access to `/root/` | Never use `/root/` — use the path confirmed by `pwd` |

### Rule for Every File-Writing Session

Before any `mkdir`, `cat >`, or file write command:

```bash
echo $HOME && pwd
```

This confirms the actual writable working directory before any file generation begins.

---

## Section 9: For New Developers

1. Clone the repo
2. Create a Supabase project
3. Apply all migrations in `supabase/migrations/` in order
4. Copy `.env.example` to `.env` and fill in your Supabase URL and anon key
5. Open `index.html` in a browser — no build step required
6. Never put real client names in repo URLs, file names, or commit messages
7. Never put API keys in code — use Supabase Vault

---

*Last updated: 2026-05-15 15:20 EDT — Session 4: OD-001 added, Module 2 extended seed documented*
