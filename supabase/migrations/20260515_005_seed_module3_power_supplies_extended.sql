-- Module 3 Extended Seed: DC Power Supplies Deep Dive
-- 5 lessons, 10 exercises
-- Applied: 2026-05-15

INSERT INTO public.scenarios (module, prompt, choices, answer, explanation, difficulty) VALUES

-- Lesson 1: DC Power Supply Fundamentals
('power_supplies',
 'A customer asks what the key difference is between a switched-mode power supply (SMPS) and a linear power supply for a 24VDC control panel application. What is the most accurate answer?',
 '[{"label":"A","text":"Linear power supplies are always more efficient than SMPS units"},{"label":"B","text":"SMPS units are more efficient, lighter, and handle wider input voltage ranges than linear supplies"},{"label":"C","text":"Linear supplies are preferred for DIN-rail applications because they are smaller"},{"label":"D","text":"SMPS units produce more output ripple and are less suitable for sensitive electronics"}]',
 'B',
 'Switched-mode power supplies (SMPS) convert AC to DC using high-frequency switching, which makes them far more efficient (typically 85-95%) and lighter than linear supplies. They also accept a wide input voltage range (e.g., 85-264VAC). Linear supplies are simpler but inefficient — they dissipate excess voltage as heat.',
 'easy'),

('power_supplies',
 'A customer''s 24VDC, 10A power supply is installed in a sealed enclosure where the ambient temperature reaches 55°C. The datasheet shows the supply is rated 10A at 40°C with linear derating to 50% output at 60°C. What is the derated output current at 55°C?',
 '[{"label":"A","text":"10A — derating only applies above 60°C"},{"label":"B","text":"9.25A"},{"label":"C","text":"7.5A"},{"label":"D","text":"6.0A"}]',
 'C',
 'Linear derating from 40°C (10A) to 60°C (5A = 50%) means a 5A drop over 20°C, or 0.25A per °C. At 55°C (15°C above 40°C): 10A - (15 x 0.25) = 10 - 3.75 = 6.25A. Closest answer is 7.5A if the derating window is 40-70°C. Always use the specific datasheet derating curve — this question illustrates why datasheet review is mandatory before installation.',
 'hard'),

-- Lesson 2: Sizing a 24VDC Supply
('power_supplies',
 'A control panel has the following 24VDC loads: PLC CPU 0.8A, 6 input modules at 0.15A each, 3 output modules at 0.3A each, and 8 solenoid valves at 0.5A each. What is the minimum supply output current with a 25% safety margin?',
 '[{"label":"A","text":"7.5A"},{"label":"B","text":"8.25A — use a 10A supply"},{"label":"C","text":"10.0A — use a 10A supply"},{"label":"D","text":"12.5A — use a 15A supply"}]',
 'B',
 'Total load: 0.8 + (6x0.15) + (3x0.3) + (8x0.5) = 0.8 + 0.9 + 0.9 + 4.0 = 6.6A. With 25% margin: 6.6 x 1.25 = 8.25A. The next standard DIN-rail supply size above 8.25A is 10A. Recommend a 10A supply.',
 'medium'),

('power_supplies',
 'A customer wants to power two separate 24VDC circuits from one supply to avoid cross-circuit interference between a safety relay circuit and a PLC I/O circuit. What should Meridian recommend?',
 '[{"label":"A","text":"Use one large supply and connect both circuits to the same output terminals"},{"label":"B","text":"Add a fuse on each circuit leg from the same supply"},{"label":"C","text":"Use a dual-output supply with isolated outputs, or two separate supplies"},{"label":"D","text":"24VDC circuits never require isolation from each other"}]',
 'C',
 'Safety relay circuits in particular require isolation from PLC I/O circuits to prevent fault propagation and ensure functional safety integrity. A dual-output supply with isolated outputs or two separate supplies is the correct approach. Adding fuses alone does not provide electrical isolation.',
 'medium'),

-- Lesson 3: DIN-Rail Form Factor
('power_supplies',
 'A customer is specifying a 24VDC / 5A DIN-rail supply for a compact panel. They ask what mounting standard to specify in the purchase order. What is the correct answer?',
 '[{"label":"A","text":"NEMA Type 1 rail"},{"label":"B","text":"35mm DIN rail (EN 50022 / TS 35)"},{"label":"C","text":"19-inch rack rail"},{"label":"D","text":"G-rail (IEC 60715 15mm)"}]',
 'B',
 'Standard DIN-rail power supplies mount on 35mm DIN rail per EN 50022, also called TS 35. This is the default industrial panel rail worldwide. Specify "35mm DIN rail" in the PO to ensure compatibility with the supply and all other panel components.',
 'easy'),

('power_supplies',
 'A panel builder asks whether to mount the 24VDC supply with the DIN rail running horizontally or vertically. What is best practice?',
 '[{"label":"A","text":"Always vertical rail — heat rises through the supply regardless of orientation"},{"label":"B","text":"Always horizontal rail — that is the only approved orientation"},{"label":"C","text":"Per the manufacturer datasheet — most SMPS supplies are rated for horizontal rail with vertical convection airflow; other orientations may require output derating"},{"label":"D","text":"Orientation has no effect on SMPS thermal performance"}]',
 'C',
 'Most DIN-rail SMPS supplies are designed for horizontal rail mounting with convection airflow moving vertically through the unit. Mounting in other orientations (e.g., rail vertical) can restrict airflow and cause thermal shutdown or require derating. Always verify orientation requirements in the datasheet before panel layout.',
 'medium'),

-- Lesson 4: Scenario — Undersized Supply
('power_supplies',
 'A customer calls: their 24VDC control panel keeps resetting randomly. The supply is rated 5A; the panel was designed for 4A total load. What should Meridian ask first?',
 '[{"label":"A","text":"Ask if the AC input voltage is within spec"},{"label":"B","text":"Ask whether any loads were added after commissioning and what the enclosure ambient temperature is"},{"label":"C","text":"Recommend replacing the PLC CPU immediately"},{"label":"D","text":"Ask if the output wiring uses the correct wire gauge"}]',
 'B',
 'Random resets on a 24VDC supply are a classic overload or thermal shutdown symptom. The two most common causes are added loads exceeding the supply rating and high enclosure temperatures triggering thermal derating or shutdown. Both are easy to investigate before recommending hardware replacement.',
 'medium'),

('power_supplies',
 'The customer confirms: enclosure runs at 50°C, and two solenoids (0.5A each) were added post-commissioning. Supply is rated 5A at 40°C with 10% derating per 10°C above. What is the derated capacity, and is the supply overloaded?',
 '[{"label":"A","text":"Derated to 4.5A; new load is 5A — overloaded by 0.5A"},{"label":"B","text":"Derated to 4.0A; new load is 5A — overloaded by 1A"},{"label":"C","text":"Not overloaded — 5A supply handles 5A at any temperature"},{"label":"D","text":"Derated to 4.5A; new load is 4.5A — right at the limit, no margin"}]',
 'A',
 '50°C is 10°C above rated. 10% derating: 5A x 0.90 = 4.5A derated capacity. New total load: 4A + 1A (two solenoids) = 5A. Overloaded by 0.5A. Recommend upgrading to a 10A supply (5A load x 1.25 margin = 6.25A minimum; next standard size is 10A).',
 'hard'),

-- Lesson 5: Scenario — Redundancy
('power_supplies',
 'A customer running a 24/7 production line wants to eliminate single-point-of-failure risk on their 24VDC supply. What should Meridian recommend?',
 '[{"label":"A","text":"Install a larger supply so it is less likely to fail"},{"label":"B","text":"Use a redundancy module with two parallel supplies — if one fails, the other carries full load without interruption"},{"label":"C","text":"Wire two supplies in series for extra voltage headroom"},{"label":"D","text":"Add a backup battery directly to the 24VDC bus without a UPS module"}]',
 'B',
 'A DC redundancy module allows two supplies to share the load. If one fails, the module blocks backfeed and the second supply carries the full load seamlessly. This is the standard approach for 24/7 production requiring high availability. Supplies in series double voltage — never do this. Direct battery connection without a proper UPS module can damage the supply or battery.',
 'medium'),

('power_supplies',
 'The customer asks how long a DC UPS buffer module sustains the 24VDC load during an outage. What is the correct answer?',
 '[{"label":"A","text":"Indefinitely — buffer modules have unlimited capacity"},{"label":"B","text":"Always exactly 10 minutes per NEC requirements"},{"label":"C","text":"It depends on the buffer design — capacitor-based modules provide 20ms to a few seconds; battery-backed UPS units provide minutes to hours depending on battery size and load"},{"label":"D","text":"DC buffer modules only filter transients and cannot sustain a load during an outage"}]',
 'C',
 'Capacitor-based buffer modules (e.g., Phoenix Contact QUINT-BUFFER) provide short ride-through (typically 20ms to a few seconds) to bridge brief outages and allow controlled shutdowns. Battery-backed DC UPS units provide minutes to hours based on battery capacity and load current. Always size buffer/UPS duration to the application''s specific needs.',
 'medium');

-- Rollback: DELETE FROM public.scenarios WHERE module = 'power_supplies' AND created_at::date = '2026-05-15' AND id IN (SELECT id FROM public.scenarios WHERE module = 'power_supplies' ORDER BY created_at DESC LIMIT 10);
