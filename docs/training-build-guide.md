# Sales Scenario Training Portal – Build Guide

This guide explains how the training portal is built, step by step. It is written for developers who want to understand, fork, or extend the project.

---

## 1. What This Portal Does

This is a gamified sales training tool. Sales reps work through realistic customer scenarios to build product knowledge and selection confidence across six product categories sourced from EIA's Schneider Electric stocked product line.

**The mechanic:**
- A customer situation is described (e.g., "A customer needs a VFD for a 480V centrifugal pump. What drive series applies?")
- The rep picks the best answer from 2–4 choices
- Instant feedback explains why the answer is correct or incorrect
- Correct answers earn XP; completing a module earns a badge
- A leaderboard tracks top performers by name (no login required)

**Content source:** EIA-Schneider Stock Document Rev C (051426). All technical content, part numbers, and selection logic come directly from this document.

---

## 2. Architecture

### Deliverable A — Live Portal (GitHub Pages)

```
Browser (GitHub Pages)
    └── Static HTML/CSS/JS
            └── Supabase JS client (CDN)
                    └── Supabase Postgres
                            └── sales_training schema
```

### Deliverable B — Offline Zip

```
index.html
    └── <script> with embedded exerciseData = [ ... ]
```

No server, no CDN, no internet required. Opens from the local filesystem in any modern browser.

---

## 3. Data Model

### Schema: `sales_training`

All tables live in the `sales_training` schema (not `public`) to isolate this project from other tables on the same Supabase instance.

#### Content Tables (public read)

| Table | Key Fields | Purpose |
|---|---|---|
| `modules` | `title`, `badge_name`, `badge_icon`, `order_index` | Top-level product categories |
| `lessons` | `module_id`, `title`, `xp_reward`, `order_index` | Lessons within a module |
| `exercises` | `lesson_id`, `exercise_type`, `prompt`, `points_value` | Individual questions |
| `exercise_options` | `exercise_id`, `option_text`, `is_correct`, `feedback` | Answer choices |

#### Session Tables (public read + write)

| Table | Key Fields | Purpose |
|---|---|---|
| `sessions` | `id` (client UUID), `last_active` | Anonymous play session |
| `progress` | `session_id`, `lesson_id`, `score`, `xp_earned`, `completed` | Lesson completion tracking |
| `responses` | `session_id`, `exercise_id`, `selected_option`, `is_correct` | Per-exercise answers |
| `leaderboard` | `player_name`, `total_xp`, `badges_earned[]` | Named scores, no auth |

### Exercise Types

| Type | Description |
|---|---|
| `multiple_choice` | Pick the correct answer from options |
| `true_false` | True or false statement |
| `scenario_rank` | Rank options in the correct order |
| `fill_in` | Complete the blank |

### Gamification Fields
- `exercises.points_value` — XP earned per correct answer
- `lessons.xp_reward` — bonus XP on lesson completion
- `modules.badge_name` + `modules.badge_icon` — awarded on module completion
- `leaderboard.badges_earned` — text array of badge names earned

---

## 4. Content Map

| # | Module | Badge | Lessons |
|---|---|---|---|
| 1 | Variable Frequency Drives | 🏆 Drive Selector | 6 seeded |
| 2 | Miniature Circuit Breakers | ⚡ Circuit Breaker | Pending Seed-03 |
| 3 | DC Power Supplies | 🔋 Power Pro | Pending Seed-04 |
| 4 | Motor Starting & Protection | 🛡️ Motor Master | Pending Seed-05 |
| 5 | Relays | 🔌 Relay Ace | Pending Seed-06 |
| 6 | Pushbuttons & Indicators | 🔴 Panel Builder | Pending Seed-06 |

### VFD Module — Lessons (Seeded)
1. VFD Fundamentals (20 XP)
2. Constant Torque vs Variable Torque (20 XP)
3. Enclosures & Communications (25 XP)
4. ATV320 vs ATV630 — Choosing the Right Series (25 XP)
5. Scenario: The Conveyor (40 XP)
6. Scenario: The Pump Upgrade (40 XP)

---

## 5. Seeding Approach

Content is seeded in discrete operations — one per module — so each can be reviewed and confirmed before proceeding.

| Op | Migration | Scope |
|---|---|---|
| Seed-01 | 20260515_002 | All 6 modules + VFD lessons |
| Seed-02 | 20260515_003 | VFD exercises + options |
| Seed-03 | TBD | Circuit Breaker lessons + exercises |
| Seed-04 | TBD | DC Power Supply lessons + exercises |
| Seed-05 | TBD | Motor Starting & Protection lessons + exercises |
| Seed-06 | TBD | Relays + Pushbuttons lessons + exercises |

**Rule:** Never edit a migration once it has been applied to production. If a seed needs correction, write a new migration.

---

## 6. Build Order

1. **Schema** ✅ — `sales_training` schema migrated (20260515_001)
2. **Seed-01** ✅ — 6 modules + VFD lessons (20260515_002)
3. **Seed-02 through Seed-06** — remaining lessons and exercises
4. **Module picker UI** — card per module, shows badge + XP available
5. **Lesson player** — lesson list → exercise loop → XP reward screen
6. **Exercise engine** — renders each exercise type (MC, T/F, rank, fill-in)
7. **Leaderboard** — player names entry + score display
8. **Supabase JS wiring** — connect CDN client to `sales_training` schema
9. **GitHub Pages deploy** — enable Pages on `main`
10. **Pixel animation CSS** — final visual pass (deferred)
11. **Offline zip build** — embed exercise data, test offline, attach to Release
12. **v1.0 tag**

---

## 7. Supabase Connection

Project ID: `hhyhulqngdkwsxhymmcd`

To connect from the front end:

```html
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script>
  const { createClient } = supabase;
  const client = createClient(
    'YOUR_SUPABASE_PROJECT_URL',
    'YOUR_SUPABASE_ANON_KEY'
  );

  // Query exercises for a lesson
  async function loadExercises(lessonId) {
    const { data } = await client
      .schema('sales_training')
      .from('exercises')
      .select('*, exercise_options(*)')
      .eq('lesson_id', lessonId)
      .order('order_index');
    return data;
  }
</script>
```

> ⚠️ Use the anon/publishable key only. Never use the service role key in frontend code.

---

## 8. Session Management (No Auth)

Because there is no authentication, sessions are managed with a client-generated UUID:

```js
// On app load
let sessionId = sessionStorage.getItem('training_session_id');
if (!sessionId) {
  sessionId = crypto.randomUUID();
  sessionStorage.setItem('training_session_id', sessionId);
  // Insert into sales_training.sessions
  await client.schema('sales_training').from('sessions').insert({ id: sessionId });
}
```

> Note: `localStorage` is blocked in sandboxed iframes. Use `sessionStorage` for in-browser persistence, or in-memory variables if the portal is embedded.

---

## 9. Sandbox Environment Notes

When using an AI assistant to generate and write files in a sandbox environment, the filesystem does **not** follow a standard Linux home directory layout.

### Known Failure Modes

| Error | Cause |
|---|---|
| `/bin/bash: /home/user/...: No such file or directory` | `~` resolves to `/home/user/` which doesn't exist in this sandbox |
| `mkdir: cannot create directory '/root': Permission denied` | Sandbox user has no write access to `/root/` |

### Fix — Confirm the Path First

```bash
echo $HOME && pwd
```

Run this before any file-write commands. Once confirmed, all generation and `share_files` delivery will work normally.

---

## 10. Repo Naming & Privacy Rule

This repo uses a generic, privacy-safe name. **Never include client names, partner names, or proprietary identifiers in:**
- The GitHub repo name or URL
- Branch names
- Commit messages
- Public-facing documentation

This rule applies to all Warrior X ecosystem repos handling client or partner work. See `warrior-x-docs/operations/training-manual.md` Chapter 9 for the full security policy.

---

## 11. For New Developers

- Read Section 3 (Data Model) first — that is the full data contract.
- Add new exercises by inserting rows into `sales_training.exercises` and `sales_training.exercise_options` — no code changes needed.
- All exercise types are rendered by the same engine; `exercise_type` controls which UI component is shown.
- To adapt for a different product line: replace seed data. Schema and UI require no changes.
- Before generating files with an AI assistant, always run `echo $HOME && pwd` first (Section 9).
- Never commit secrets. API keys go in the Supabase Vault only.

---

*Update this guide whenever a new pattern is established, a schema change is made, or a build step is completed.*
