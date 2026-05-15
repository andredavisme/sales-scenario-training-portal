# Sales Scenario Training Portal — Progress Log

## Current Status
Supabase schema live. Seed-01 complete — all 6 modules and Module 1 (VFD) lessons inserted. Exercises not yet seeded.

## Active Work
Seed-02 (VFD exercises + options) — pending. On branch: `docs/auto-update-20260515`.

## Last Session
Date: 2026-05-15
Connected Supabase account. Confirmed existing tables belong to other projects. Designed and migrated a clean `sales_training` schema (8 tables, all RLS enabled). Parsed EIA-Schneider source doc — identified 6 modules, ~16 lessons, 40–60 exercises. Ran Seed-01: all 6 modules + 6 VFD lessons seeded successfully.

## Completed Milestones
- 2026-05-15 — Repo renamed from `eia-schneider-training-portal` to `sales-scenario-training-portal`
- 2026-05-15 — `sales_training` Supabase schema created (migration: 20260515_001)
- 2026-05-15 — Seed-01 applied: 6 modules + 6 VFD lessons (migration: 20260515_002)

## Open Decisions
- Pixel animation CSS style direction — deferred until after full content build
- Whether to add a content-management UI for André to edit modules/lessons without SQL

## Blockers
None.

## Seed Progress
| Op | Scope | Status |
|---|---|---|
| Seed-01 | All 6 modules + VFD lessons | ✅ Done |
| Seed-02 | VFD exercises + options | ⏳ Next |
| Seed-03 | Circuit Breaker lessons + exercises | 🔲 Pending |
| Seed-04 | DC Power Supply lessons + exercises | 🔲 Pending |
| Seed-05 | Motor Starting & Protection lessons + exercises | 🔲 Pending |
| Seed-06 | Relays + Pushbuttons lessons + exercises | 🔲 Pending |

## Next Steps
1. Run Seed-02 — VFD exercises and answer options
2. Confirm Seed-02 rows in Supabase
3. Continue through Seed-03 to Seed-06
4. Scaffold frontend HTML against live schema
5. Add pixel animation CSS layer as final UI pass

---
*Last updated: 2026-05-15 14:44 EDT — Seed-01 complete, schema live, 6 modules + 6 VFD lessons in DB*
