# EIA Schneider Training – Project Progress

This living document tracks milestones and decisions for the EIA Schneider interactive training portal.

## 1. Project Overview
- Purpose: Help Eastern Industrial Automation reps confidently sell Schneider drives, breakers, starters, power supplies, and controls using an interactive, web-based training portal.
- Audience: Adult sales professionals with limited attention span and low tolerance for technical deep dives.
- Core idea: Short, scenario-based exercises with instant feedback derived from EIA's Schneider stock document.

## 2. Build Order (Decided 2026-05-15)
1. Supabase schema design + apply migration
2. Trigger testing (e.g., updated_at, scoring)
3. Seed scenario data from EIA Schneider stock document
4. Security review — RLS policies, no service key in frontend
5. Build scenario module (module picker + scenario player) — design pass
6. Test scenario module for function
7. Integrate scenario module with platform shell
8. Test integration for function
9. Build full platform UI — design pass
10. Test platform for function

## 3. High-Level Milestones
- [x] Create dedicated GitHub repo for the training portal
- [x] Define build order
- [ ] Create Supabase project
- [ ] Design and apply `scenarios` table schema
- [ ] Trigger testing passes
- [ ] Seed initial scenario data
- [ ] Security review passes (RLS on all tables)
- [ ] Module UI built and functional
- [ ] Module integrated with platform
- [ ] Full platform UI built and functional
- [ ] Pilot with small sales group and collect feedback
- [ ] Iterate based on feedback

## 4. Current Status
- Branch: `main`
- Phase: Pre-development. Schema work begins next session.

## 5. Open Decisions
- EIA branding assets (colors, logo)
- Confirm Schneider stock document availability for content seeding
- Supabase project to create or identify

---
*Last updated: 2026-05-15*
