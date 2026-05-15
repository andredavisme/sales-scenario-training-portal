# Sales Scenario Training Portal – Project Progress

This living document tracks milestones and decisions for the training portal.

---

## 1. Project Overview

- **Purpose:** A gamified sales training portal that teaches reps how to select and specify Schneider Electric / EIA-stocked products through realistic customer scenarios.
- **Content source:** EIA-Schneider Stock Document Rev C (051426) — covers VFDs, circuit breakers, DC power supplies, motor starting & protection, relays, and pushbuttons/indicators.
- **Backend:** Supabase (Postgres) — `sales_training` schema, isolated from other projects on the same instance.
- **Frontend:** Static HTML/CSS/JS, hosted on GitHub Pages.
- **Gamification:** XP per lesson, badges per module, anonymous leaderboard (no auth required).
- **Visual style:** Pixel animation CSS layer — deferred until after full content build.
- **Repo naming note:** This repo uses a generic name. No client names, brand names, or proprietary identifiers appear in the repo name, URLs, or public-facing documentation. See `docs/training-build-guide.md` Section 10.

---

## 2. Deliverables

### Deliverable A — Live Portal (GitHub Pages)
- Supabase-backed scenario engine
- Module picker → Lesson player → Exercise loop → XP + badge rewards
- Anonymous leaderboard
- Hosted on GitHub Pages from `main` branch

### Deliverable B — Offline Zip
- Self-contained `index.html` with all scenario data embedded in JS
- No server, CDN, or internet connection required
- Launchable from any modern browser directly from the filesystem
- Distributed as a `.zip` attached to a GitHub Release

---

## 3. Architecture

### Schema — `sales_training` (Supabase)

| Table | Purpose |
|---|---|
| `modules` | Top-level product categories (6 total) |
| `lessons` | Lessons within each module |
| `exercises` | Individual questions/scenarios within each lesson |
| `exercise_options` | Answer choices for each exercise |
| `sessions` | Anonymous browser session (client-generated UUID) |
| `progress` | Per-session lesson completion and XP tracking |
| `responses` | Per-session per-exercise answer attempts |
| `leaderboard` | Named scores — player picks a name, no auth |

All 8 tables have RLS enabled. Public read on content tables. Public read+write on session/progress/response/leaderboard tables.

### Exercise Types
- `multiple_choice` — pick the correct answer
- `true_false` — true or false statement
- `scenario_rank` — rank options in correct order
- `fill_in` — complete the blank

### Gamification
- Each exercise has a `points_value`
- Each lesson has an `xp_reward`
- Each module has a `badge_name` and `badge_icon` awarded on completion
- Anonymous leaderboard tracks `player_name`, `total_xp`, and `badges_earned[]`

---

## 4. Content Map

| Module | Badge | Lessons | XP Available |
|---|---|---|---|
| 1 — Variable Frequency Drives | 🏆 Drive Selector | 6 | 170 |
| 2 — Miniature Circuit Breakers | ⚡ Circuit Breaker | TBD | TBD |
| 3 — DC Power Supplies | 🔋 Power Pro | TBD | TBD |
| 4 — Motor Starting & Protection | 🛡️ Motor Master | TBD | TBD |
| 5 — Relays | 🔌 Relay Ace | TBD | TBD |
| 6 — Pushbuttons & Indicators | 🔴 Panel Builder | TBD | TBD |

---

## 5. Seed Progress

| Op | Migration | Scope | Status |
|---|---|---|---|
| Seed-01 | 20260515_002 | All 6 modules + Module 1 VFD lessons | ✅ Done |
| Seed-02 | 20260515_003 | VFD exercises + options | ⏳ Next |
| Seed-03 | TBD | Circuit Breaker lessons + exercises | 🔲 Pending |
| Seed-04 | TBD | DC Power Supply lessons + exercises | 🔲 Pending |
| Seed-05 | TBD | Motor Starting & Protection lessons + exercises | 🔲 Pending |
| Seed-06 | TBD | Relays + Pushbuttons lessons + exercises | 🔲 Pending |

---

## 6. Build Progress

### Foundation
- [x] Repo created and named with privacy-safe generic name
- [x] `sales_training` Supabase schema designed and migrated
- [x] Source document parsed — 6 modules, ~16 lessons, 40–60 exercises identified
- [x] Seed-01 applied — 6 modules + 6 VFD lessons live
- [ ] Seed-02 through Seed-06 — exercises and options
- [ ] Module picker UI
- [ ] Lesson player + exercise loop
- [ ] XP + badge reward system
- [ ] Anonymous leaderboard
- [ ] Supabase JS client wiring
- [ ] GitHub Pages deployment
- [ ] Pixel animation CSS layer
- [ ] Offline zip build
- [ ] v1.0 release

---

## 7. Session Log

### Session 3 — 2026-05-15
- Connected Supabase account — confirmed existing tables belong to other projects on same instance
- Designed `sales_training` schema (8 tables, all RLS enabled) — isolated in its own schema
- Parsed EIA-Schneider source doc (Rev C, 051426) — identified 6 modules, ~16 lessons, 40–60 exercises
- Applied migration 20260515_001 — `sales_training` schema created
- Applied migration 20260515_002 (Seed-01) — all 6 modules + 6 VFD lessons seeded
- Confirmed Seed-01 rows live in Supabase
- Overhauled `docs/progress.md` and `docs/training-build-guide.md` to reflect real schema and content plan
- Renamed repo context: `eia-schneider-training-portal` → `sales-scenario-training-portal`

### Session 2 — 2026-05-15
- Diagnosed sandbox filesystem errors (see `docs/training-build-guide.md` Section 9)
- No code changes — documentation only

### Session 1 — 2026-05-15
- Initial repo setup, dual-deliverable plan established
- Old schema (`scenarios` table in `public`) and mock data (Meridian/VoltEdge) — superseded by Session 3 redesign

---

*Last updated: 2026-05-15 14:46 EDT — Seed-01 complete, docs overhauled to reflect real schema and Schneider content*
