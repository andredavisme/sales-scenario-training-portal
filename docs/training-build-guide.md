# Sales Scenario Training Portal – Build Guide

This guide explains how the training portal is built, step by step. It is written for developers who want to understand, fork, or extend the project.

---

## 1. Concept Overview

**The mock scenario:** Meridian Industrial Supply is a fictitious industrial distributor whose sales reps need to quickly learn a new product line — VoltEdge (VFDs, breakers, power supplies, starters, and controls). This mock scenario mirrors a real and common sales enablement challenge without exposing any proprietary data.

**The mechanic:**
- A customer situation is described (e.g., "A customer needs a 5HP drive for a 460V conveyor application").
- The rep picks the best answer from 3–4 choices.
- Instant feedback explains why the answer is correct or incorrect.
- Reps build pattern recognition across product categories without needing deep technical knowledge.

---

## 2. Architecture

### Deliverable A — Public Educational Template

```
Browser (GitHub Pages)
    └── Static HTML/CSS/JS
            └── Supabase JS client
                    └── Supabase (Postgres)
                            └── scenarios table
```

- Front end: Static site hosted on GitHub Pages.
- Back end: Supabase project (free tier is sufficient).
- Scenarios are rows in a Postgres table, fetched at runtime via the Supabase JS client.
- No build tool required — vanilla JS with a CDN-loaded Supabase client.

### Deliverable B — Internal Handoff Zip

```
index.html
    └── <script> with embedded scenarioData = [ ... ]
```

- No server, no CDN, no internet connection required.
- All scenario data is a plain JS array embedded directly in the HTML file.
- Opens in any modern browser from the local filesystem.
- Ideal for distribution via email or shared drive.

---

## 3. Data Model

Each scenario is one record with these fields:

| Field | Type | Description |
|---|---|---|
| `id` | integer | Auto-incremented primary key |
| `module` | text | Product category (e.g., `drives`, `breakers`) |
| `prompt` | text | The customer situation described to the rep |
| `choices` | jsonb | Array of `{ label, text }` objects (A, B, C, D) |
| `answer` | text | The correct choice label (e.g., `"B"`) |
| `explanation` | text | Why that answer is correct |
| `difficulty` | text | `easy`, `medium`, or `hard` |

### Example Row

```json
{
  "module": "drives",
  "prompt": "A customer needs a drive for a 5HP, 460V, 3-phase conveyor motor. Which VoltEdge VFD is the right fit?",
  "choices": [
    { "label": "A", "text": "VE-VFD-2HP-230V" },
    { "label": "B", "text": "VE-VFD-5HP-460V" },
    { "label": "C", "text": "VE-VFD-10HP-460V" },
    { "label": "D", "text": "VE-STARTER-5HP" }
  ],
  "answer": "B",
  "explanation": "Match HP and voltage exactly. The VE-VFD-5HP-460V is the correct fit. Option C is oversized. Option D is a starter, not a VFD.",
  "difficulty": "easy"
}
```

---

## 4. UI Components

### Module Picker
- Displays a card or button for each product category.
- Clicking a module loads scenarios for that category.

### Scenario Player
- Shows the prompt and four answer choices.
- On selection: highlights correct/incorrect, shows explanation.
- "Next" button advances to the next scenario.
- Progress indicator shows how many scenarios remain.

### Score Summary (optional)
- At the end of a module, shows total correct / total attempted.
- Encourages retry.

---

## 5. Build Order

1. **Schema** — define and apply the `scenarios` table in Supabase.
2. **Seed data** — write 5–10 scenarios per module in the mock VoltEdge catalog.
3. **Scenario player** — build the core UI loop (prompt → choices → feedback → next).
4. **Module picker** — build the entry screen.
5. **Supabase wiring** — connect the JS client to fetch scenarios by module.
6. **Zip build** — copy the same UI, replace Supabase fetch with embedded JS array.
7. **Deploy** — enable GitHub Pages; package zip and attach to Release.

---

## 6. For New Developers

- Start by reading the example scenario row above — that is the entire data contract.
- You can add new scenarios without touching any JavaScript by inserting rows in Supabase.
- The front-end code never hardcodes product names — everything comes from the data.
- The zip build is a manual step: copy the final HTML, paste in the scenario array, test offline.

Future sections of this guide will include:
- Supabase setup walkthrough (project creation, table migration, API key)
- Full annotated source code for the scenario player
- GitHub Pages deployment steps
- How to swap in real product data for internal use

---

*As you work through the build, update this guide with what you learn. It should always reflect the current state of the project.*
