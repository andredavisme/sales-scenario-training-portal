# EIA Schneider Training Portal — Project Training Manual

> This manual covers what is unique to this repo.
> All global standards live in andredavisme/warrior-x-docs/operations/training-manual.md.

## What This Repo Is
An interactive, web-based training portal that helps Eastern Industrial Automation (EIA) sales reps confidently sell Schneider Electric products. Learners work through short, realistic customer scenarios with multiple-choice answers and instant feedback.

## Who It Serves
- **Primary users:** EIA sales professionals
- **Secondary users:** EIA managers reviewing rep progress
- **Builders:** Warrior X citizen developer students learning Supabase + static front-end development

## Tech Stack
- **Front end:** Static HTML/CSS/JS — hosted on GitHub Pages
- **Back end / data:** Supabase (Postgres + REST API)
- **Version control:** GitHub (`andredavisme/eia-schneider-training-portal`)
- **Content source:** EIA Schneider stock document (VFDs, breakers, power supplies, starters, relays, pushbuttons)

## Key Conventions
- Migration files: `YYYYMMDD_NNN_description.sql` — never edit once applied to production
- Branch naming: `feat/`, `fix/`, `schema/`, `docs/` prefixes
- Commit format: `<type>: <short description>`
- All Supabase tables must have RLS enabled — no exceptions
- No service role key in any frontend file — ever
- API keys and secrets go in Supabase Vault only

## Data Model (to be built)
- `scenarios` table — core content unit:
  - `id` (uuid, PK)
  - `module` (text) — e.g., 'drives', 'breakers', 'power_supplies'
  - `prompt` (text) — the customer scenario
  - `options` (jsonb) — array of choice strings
  - `correct_index` (int) — index of correct option
  - `explanation` (text) — shown after answer
  - `difficulty` (text) — 'beginner' | 'intermediate' | 'advanced'
  - `created_at`, `updated_at` (timestamptz)
- Additional tables TBD: `user_progress`, `sessions`

## Build Order
1. Supabase schema + migration
2. Trigger testing
3. Seed scenario data
4. Security review (RLS)
5. Scenario module — design
6. Scenario module — function test
7. Platform integration
8. Platform integration — function test
9. Platform UI — design
10. Platform UI — function test

## How to Contribute
1. Branch from `main` using the correct prefix
2. Make changes, write a clear commit message
3. Open a PR — do not merge your own PR
4. Leave for André to review

## Security Rules
- RLS must be enabled on every Supabase table
- The `anon` key is the only key that may appear in frontend code
- The service role key must never be committed or hardcoded
- Secrets go in Supabase Vault — reference by name, never by value
- No `.env` files committed to the repo

## Chapter 15 — Post-Mortems & Lessons Learned
*(No incidents yet — this section will be filled in as the project progresses.)*
