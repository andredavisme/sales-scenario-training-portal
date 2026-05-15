# Sales Scenario Training Portal – Project Progress

This living document tracks milestones and decisions for the training portal.

## 1. Project Overview

- **Purpose:** Teach developers how to build a scenario-based sales training tool, and deliver a working internal version that sales teams can use immediately.
- **Audience (template):** Developers — the repo is fully public and uses fictitious entities.
- **Audience (zip):** Sales professionals — self-contained, no technical setup required.
- **Mock scenario:** Meridian Industrial Supply reps learning to sell the VoltEdge product line (VFDs, breakers, power supplies, starters, controls). All company names, product names, and data are fictitious and use generalized industry terminology — no real brand names.
- **Core mechanic:** Short, realistic customer scenarios with multiple-choice answers and instant feedback.

## 2. Deliverables

### Deliverable A — Public Educational Template
- Supabase backend (Postgres + API) for scenario storage
- GitHub Pages frontend (static HTML/CSS/JS)
- Fully documented for developer reuse and learning
- Repo: `main` branch, public

### Deliverable B — Internal Handoff Zip
- Self-contained: all scenario data embedded in JS, no server or CDN calls required
- Single `index.html` launchable from any browser
- Packaged as a `.zip` for direct distribution
- Released via GitHub Releases

## 3. High-Level Milestones

### Foundation
- [x] Create dedicated GitHub repo
- [x] Define dual-deliverable plan (public template + internal zip)
- [x] Establish mock scenario: Meridian Industrial Supply / VoltEdge
- [x] Finalize mock product catalog (VFDs, breakers, power supplies, starters, controls)
- [x] Write seed scenarios — 18 scenarios across all 5 modules
- [x] Rename repo to `sales-scenario-training-portal` to remove client identifiers from public URL
- [ ] **OPEN DECISION: Decide where SQL seed files live** (Supabase direct vs. `supabase/migrations/` in repo)

### Deliverable A — Public Template
- [x] Design Supabase schema (`scenarios` table)
- [x] Apply migration to Supabase project
- [x] Seed mock data (18 scenarios, all modules)
- [ ] Create `supabase/migrations/` directory and version-control all seed SQL
- [ ] Build module picker UI (GitHub Pages)
- [ ] Build scenario player with instant feedback
- [ ] Wire Supabase client to front-end
- [ ] Enable GitHub Pages deployment
- [ ] Publish and document for developer reuse

### Deliverable B — Internal Zip
- [ ] Build self-contained `index.html` with embedded scenario data
- [ ] Match UI/UX of the public template
- [ ] Bundle all assets (no external CDN calls)
- [ ] Test offline in Chrome, Firefox, Safari, Edge
- [ ] Package as `.zip` and attach to GitHub Release

### Validation
- [ ] Pilot with small group and collect feedback
- [ ] Iterate on content and UX
- [ ] Tag v1.0 release

## 4. Open Decisions

### OD-001 — Where do SQL seed files live?
**Raised:** 2026-05-15 Session 4

The repo has no `supabase/migrations/` directory. Seeds applied to date (18 scenarios across 5 modules) were run directly via Supabase MCP tool and are not version-controlled in the repo. Module 2 extended seed content (5 lessons / 10 exercises / 40 options for circuit breakers) is designed but not yet applied or committed.

**Options:**
- **A — Supabase direct + push SQL to repo:** Apply via MCP tool AND push `.sql` files to `supabase/migrations/` for version control. Best practice.
- **B — Supabase direct only:** No SQL files in repo. Faster but seeds are not reproducible without the Supabase project.
- **C — Repo only:** Push SQL files, André applies manually. Useful if CI/CD migration runner is planned.

**Recommendation:** Option A. Resolve before Session 5.

## 5. Session Log

### Session 4 — 2026-05-15
- Designed Module 2 extended seed (circuit breakers): 5 lessons, 10 exercises, 40 answer options
  - Breaker Fundamentals, Breaker Sizing (NEC), MCCB vs MCB vs GFCI/AFCI, Scenario: Panel Upgrade, Scenario: Motor Branch Circuit
  - Point values: standard exercises 10pts each, scenario exercises 15pts each
- Discovered repo has no `supabase/migrations/` directory — seeds from Session 1 applied directly via Supabase MCP, not version-controlled
- Raised OD-001: seed location decision needed before Session 5
- No files committed to repo this session — pending OD-001 resolution

### Session 3 — 2026-05-15
- Identified that the original repo name (`eia-schneider-training-portal`) defeated the anonymization goal by embedding client identifiers directly in the public GitHub URL
- Renamed repo to `sales-scenario-training-portal` — generic, descriptive, no client names
- GitHub automatically redirects all existing links from the old name
- README, progress, and build guide confirmed clean — no client names in content
- Updated docs to record the rename decision and add a standing rule against client-identifying repo names

### Session 2 — 2026-05-15
- Confirmed repo access: README.md and docs/ directory visible on main
- Diagnosed sandbox filesystem errors that blocked file generation in previous session:
  - `~` resolved to `/home/user/` — a path that does not exist in the AI sandbox environment
  - `/root/` is permission-denied in the sandbox
  - Fix: begin every file-writing session with `echo $HOME && pwd` to confirm the actual writable path
- No code changes this session — diagnosis and documentation only
- Updated `docs/progress.md` and `docs/training-build-guide.md` with sandbox environment notes

### Session 1 — 2026-05-15
- Reframed project as dual-deliverable: public educational template + internal handoff zip
- Established fictitious mock scenario (Meridian Industrial Supply / VoltEdge) — no real brand names, generalized industry terminology throughout
- Updated README, progress, and build guide docs
- Applied `scenarios` table migration to Supabase (`andredavisme's Project`, `us-west-2`)
  - Schema: `id`, `module`, `prompt`, `choices` (jsonb), `answer`, `explanation`, `difficulty`, `created_at`
  - RLS enabled with public read-only policy
  - Index on `module` for fast filtering
- Seeded 18 mock scenarios across all 5 modules:
  - `drives` — 5 scenarios
  - `breakers` — 4 scenarios
  - `power_supplies` — 3 scenarios
  - `starters` — 3 scenarios
  - `controls` — 3 scenarios

---

*Last updated: 2026-05-15 15:20 EDT — Session 4: Module 2 extended seed designed, OD-001 seed location decision pending*
