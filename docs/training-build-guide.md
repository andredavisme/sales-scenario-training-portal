# Sales Scenario Training Portal – Build Guide

This guide explains how the training portal is built, step by step. It is written for developers who want to understand, fork, or extend the project.

---

## 1. Concept Overview

**The mock scenario:** Meridian Industrial Supply is a fictitious industrial distributor whose sales reps need to quickly learn a new product line — VoltEdge (VFDs, breakers, power supplies, starters, and controls). This mock scenario mirrors a real and common sales enablement challenge without exposing any proprietary data. All product names, company names, and catalog numbers are fictitious. All technical concepts use generalized industry terminology.

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

### Schema (applied to Supabase)

The `scenarios` table lives in the `public` schema with RLS enabled and a public read-only policy.

| Field | Type | Description |
|---|---|---|
| `id` | serial PK | Auto-incremented primary key |
| `module` | text | Product category: `drives`, `breakers`, `power_supplies`, `starters`, `controls` |
| `prompt` | text | The customer situation described to the rep |
| `choices` | jsonb | Array of `{ label, text }` objects (A, B, C, D) |
| `answer` | text | The correct choice label (e.g., `"B"`) |
| `explanation` | text | Why that answer is correct (and why others are not) |
| `difficulty` | text | `easy`, `medium`, or `hard` |
| `created_at` | timestamptz | Auto-set on insert |

### Example Row

```json
{
  "module": "drives",
  "prompt": "A customer needs a variable frequency drive for a 5HP, 460V, 3-phase conveyor motor. Which VoltEdge VFD is the correct fit?",
  "choices": [
    { "label": "A", "text": "VE-VFD-2HP-230V" },
    { "label": "B", "text": "VE-VFD-5HP-460V" },
    { "label": "C", "text": "VE-VFD-10HP-460V" },
    { "label": "D", "text": "VE-STARTER-5HP-460V" }
  ],
  "answer": "B",
  "explanation": "Match HP and voltage exactly. The VE-VFD-5HP-460V fits the application. Option C is oversized. Option D is a soft starter, not a VFD — it cannot vary motor speed.",
  "difficulty": "easy"
}
```

---

## 4. Seeded Content Summary

18 mock scenarios are seeded across all 5 modules. All content uses fictitious VoltEdge product names and generalized industry terminology.

| Module | Count | Topics Covered |
|---|---|---|
| `drives` | 5 | VFD sizing, torque control types, energy savings mode, enclosure ratings, overcurrent fault diagnosis |
| `breakers` | 4 | Breaker selection, competitor crossover criteria, motor branch circuit sizing (250% rule), full panels |
| `power_supplies` | 3 | 24VDC sizing with margin, temperature derating, DIN-rail form factor |
| `starters` | 3 | FVNR with overload relay, reversing starter configuration, soft starter benefits |
| `controls` | 3 | 3-wire control circuit wiring, pilot light connection, E-stop contact requirements |

---

## 5. UI Components

### Module Picker
- Displays a card or button for each product category.
- Clicking a module loads scenarios for that category from Supabase (or embedded data in zip build).

### Scenario Player
- Shows the prompt and answer choices.
- On selection: highlights correct/incorrect, shows explanation.
- "Next" button advances to the next scenario.
- Progress indicator shows position within the module.

### Score Summary (optional)
- At the end of a module, shows total correct / total attempted.
- Encourages retry.

---

## 6. Build Order

1. **Schema** ✅ — `scenarios` table created in Supabase with RLS and public read policy.
2. **Seed data** ✅ — 18 scenarios across all 5 modules inserted.
3. **Scenario player** — Build the core UI loop (prompt → choices → feedback → next).
4. **Module picker** — Build the entry screen.
5. **Supabase wiring** — Connect the Supabase JS client (CDN) to fetch scenarios by module.
6. **GitHub Pages deploy** — Enable Pages on `main`; verify live URL.
7. **Zip build** — Copy the final HTML, replace Supabase fetch with embedded JS array, test offline.
8. **Release** — Package zip, attach to GitHub Release, tag v1.0.

---

## 7. Supabase Connection (for front-end wiring)

The Supabase project is `andredavisme's Project` in region `us-west-2`.

To connect from the front end:

```html
<!-- Load Supabase JS client from CDN -->
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script>
  const { createClient } = supabase;
  const client = createClient(
    'YOUR_SUPABASE_PROJECT_URL',
    'YOUR_SUPABASE_ANON_KEY'
  );

  async function loadScenarios(module) {
    const { data, error } = await client
      .from('scenarios')
      .select('*')
      .eq('module', module)
      .order('difficulty');
    return data;
  }
</script>
```

Retrieve the project URL and anon key from the Supabase dashboard under **Project Settings → API**.

---

## 8. Repo Naming — Anonymization Rule

This project is built for a real client but published as a generic open-source template. The repo name is part of the public URL and is **not** covered by internal anonymization of content.

### The Mistake
The original repo name was `eia-schneider-training-portal`. Both identifiers in that name belong to the client. The mock scenario content was fully anonymized, but the URL itself disclosed the relationship.

### The Rule
> **Public repos for client work must use generic, descriptive names only.** No company names, person names, or project codenames that could identify the client. The repo name is always public, even when content is anonymized.

**Good names:** `sales-scenario-training-portal`, `product-training-template`, `scenario-quiz-app`

**Bad names:** `acme-corp-training`, `jane-smith-sales-tool`, `project-atlas-portal`

### Rename Notes
- Renamed to `sales-scenario-training-portal` on 2026-05-15
- GitHub automatically redirects all links from the old name — existing bookmarks and integrations are not broken
- No content changes were needed — the internal docs were already clean

---

## 9. Sandbox Environment Notes

When using an AI assistant (Perplexity, ChatGPT, etc.) to generate and write files in a sandbox environment, the sandbox filesystem does **not** follow a standard Linux home directory layout.

### Known Failure Modes

| Error | Cause |
|---|---|
| `/bin/bash: /home/user/...: No such file or directory` | `~` resolves to `/home/user/` — a path that doesn't exist in the sandbox |
| `mkdir: cannot create directory '/root': Permission denied` | The sandbox user has no write access to `/root/` |

### Fix — Confirm the Path First

Begin every file-writing session with:

```bash
echo $HOME && pwd
```

This confirms the actual writable directory before any `mkdir` or file-write commands. Once confirmed, all file generation and `share_files` delivery will work normally.

### Why This Matters for This Project

The front-end HTML for this portal will be generated in the sandbox and shared as a downloadable file. If the sandbox path is assumed rather than confirmed, the file generation step fails silently and the session must be restarted.

---

## 10. For New Developers

- Start by reading the example scenario row in Section 3 — that is the entire data contract.
- You can add new scenarios without touching any JavaScript by inserting rows in Supabase.
- The front-end code never hardcodes product names — everything comes from the data.
- The zip build is a manual step: copy the final HTML, paste in the scenario array, test offline.
- To adapt this template for a real product line: replace the mock VoltEdge data with your own scenarios. The schema and UI require no changes.
- Before generating files with an AI assistant, always run `echo $HOME && pwd` first (see Section 9).
- When forking for a new client project, name the repo generically — never use client names in the repo name (see Section 8).

---

*As you work through the build, update this guide with what you learn. It should always reflect the current state of the project.*
