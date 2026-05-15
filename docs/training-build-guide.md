# EIA Schneider Training – Student Build Guide

This living document explains how the EIA Schneider interactive training portal is built, step by step, so a new student developer can understand and extend the project.

## 1. Concept Overview
- Goal: Turn Eastern Industrial Automation's Schneider stock document into a simple, web-based training portal.
- Approach: Present short, realistic customer scenarios (e.g., drive selection, breaker crossovers) with multiple-choice answers and instant feedback.
- Outcome: Sales reps practice recognizing patterns (application type, voltage, amps, enclosure, etc.) and selecting the right Schneider products without needing deep technical knowledge.

## 2. High-Level Architecture
- Front end: Static web app hosted on GitHub Pages.
- Back end / data: Supabase (Postgres + API) stores training scenarios as rows instead of hardcoded in the UI.
- Content source: EIA Schneider stock document (VFDs, breakers, power supplies, starters, relays, pushbuttons) distilled into short rules and examples.

## 3. Core Pieces (to be expanded)
1. **Scenario data model**
   - Each scenario describes a "customer request" plus multiple-choice options and the correct answer.
2. **Module picker UI**
   - Users choose a module like Drives, Breakers, or Power Supplies.
3. **Scenario player**
   - Shows one scenario at a time with clickable choices and instant feedback.
4. **Progress tracking (optional)**
   - Track how many scenarios a learner has attempted or completed.

## 4. For New Student Developers
This project is meant to be approachable:
- You can start by editing JSON-like scenario data without touching any JavaScript.
- Then you can move into the front-end code to change how scenarios are displayed.
- Finally, you can explore Supabase to see how data is stored and retrieved.

Future sections of this guide will walk through:
- Setting up the repo locally
- Connecting to Supabase
- Defining the scenario table
- Building the module picker and scenario player
- Deploying to GitHub Pages

---

As you read, take notes on questions or ideas. This guide is meant to be updated as the project grows and as new students bring in fresh perspectives.
