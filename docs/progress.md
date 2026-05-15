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

### Deliverable A — Public Template
- [x] Design Supabase schema (`scenarios` table)
- [x] Apply migration to Supabase project
- [x] Seed mock data (18 scenarios, all modules)
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

## 4. Session Log

### Session 2 — 2026-05-15
- Confirmed repo access: README.md and docs/ directory visible on main
- Diagnosed sandbox filesystem errors that blocked file generation in previous session:
  - `~` resolved to `/home/user/` — a path that does not exist in the AI sandbox environment
  - `/root/` is permission-denied in the sandbox
  - Fix: begin every file-writing session with `echo $HOME && pwd` to confirm the actual writable path
- No code changes this session — diagnosis and documentation only
- Updated `docs/progress.md` and `docs/training-build-guide.md` with sandbox environment notes

### Next Session — Recommended Starting Point
- Build the GitHub Pages front-end: module picker UI + scenario player
- Start with `echo $HOME && pwd` to confirm sandbox path before any file writes
- Supabase project: `hhyhulqngdkwsxhymmcd` (us-west-2)
- Anon key and project URL needed from Supabase dashboard for JS client wiring

### Session 1 — 2026-05-15
- Reframed project as dual-deliverable: public educational template + internal handoff zip
- Established fictitious mock scenario (Meridian Industrial Supply / VoltEdge) — no real brand names, generalized industry terminology throughout
- Updated README, progress, and build guide docs
- Applied `scenarios` table migration to Supabase (`andredavisme's Project`, `us-west-2`)
  - Schema: `id`, `module`, `prompt`, `choices` (jsonb), `answer`, `explanation`, `difficulty`, `created_at`
  - RLS enabled with public read-only policy
  - Index on `module` for fast filtering
- Seeded 18 mock scenarios across all 5 modules:
  - `drives` — 5 scenarios (VFD selection, torque control, energy savings, enclosure ratings, fault diagnosis)
  - `breakers` — 4 scenarios (breaker selection, crossover criteria, motor protection sizing, full panels)
  - `power_supplies` — 3 scenarios (24VDC sizing, temperature derating, DIN-rail form factor)
  - `starters` — 3 scenarios (FVNR with overload, reversing starter, soft starter benefits)
  - `controls` — 3 scenarios (3-wire control circuit, pilot light wiring, E-stop requirements)

---

This file is intentionally lightweight so it can be updated frequently as the project evolves.
