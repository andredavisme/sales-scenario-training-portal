# Sales Scenario Training Portal – Project Progress

This living document tracks milestones and decisions for the training portal.

## 1. Project Overview

- **Purpose:** Teach developers how to build a scenario-based sales training tool, and deliver a working internal version that sales teams can use immediately.
- **Audience (template):** Developers — the repo is fully public and uses fictitious entities.
- **Audience (zip):** Sales professionals — self-contained, no technical setup required.
- **Mock scenario:** Meridian Industrial Supply reps learning to sell the VoltEdge product line (VFDs, breakers, power supplies, starters, controls). All company names, product names, and data are fictitious.
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
- [ ] Finalize mock product catalog (VFDs, breakers, power supplies, starters, controls)
- [ ] Write 5–10 seed scenarios per product category

### Deliverable A — Public Template
- [ ] Design Supabase schema (`scenarios` table)
- [ ] Apply migration and seed mock data
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

## 4. Current Status

- Repo created, docs updated to reflect dual-deliverable plan
- Next: finalize mock product catalog and write seed scenarios

---

This file is intentionally lightweight so it can be updated frequently as the project evolves.
