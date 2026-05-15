-- Module 2 Extended Seed: Circuit Breakers Deep Dive
-- 5 lessons, 10 exercises, 40 answer options
-- Applied: 2026-05-15

INSERT INTO public.scenarios (module, prompt, choices, answer, explanation, difficulty) VALUES

-- Lesson 1: Breaker Fundamentals
('breakers',
 'A customer asks why their new 100A breaker tripped immediately when connected to a panel fed by a 75kVA transformer. The breaker is rated 100A / 10kAIC. What is the most likely cause?',
 '[{"label":"A","text":"The breaker is undersized for the load"},{"label":"B","text":"The available fault current from the transformer exceeds the breaker AIC rating"},{"label":"C","text":"The breaker neutral is wired incorrectly"},{"label":"D","text":"The transformer secondary voltage is too high"}]',
 'B',
 'A 75kVA transformer at 480/120-240V can deliver fault currents well above 10kAIC. If available fault current exceeds the breaker AIC rating, the breaker cannot safely interrupt the fault and may fail catastrophically. The correct fix is a breaker with a higher AIC rating.',
 'medium'),

('breakers',
 'A customer is deciding between a thermal-magnetic trip breaker and an electronic trip breaker for a 400A feeder. Which statement is most accurate?',
 '[{"label":"A","text":"Thermal-magnetic breakers offer adjustable long-time and short-time delay settings"},{"label":"B","text":"Electronic trip breakers are only available up to 100A"},{"label":"C","text":"Electronic trip breakers offer field-adjustable trip settings and better precision across the full current range"},{"label":"D","text":"Thermal-magnetic breakers are always preferred for feeders above 200A"}]',
 'C',
 'Electronic trip breakers provide adjustable long-time delay, short-time delay, instantaneous, and ground fault settings — making them ideal for large feeders where precise coordination is needed. Thermal-magnetic breakers have fixed trip characteristics and are better suited for branch circuits.',
 'medium'),

-- Lesson 2: Breaker Sizing — NEC
('breakers',
 'A customer is sizing a branch circuit breaker for a 10HP, 230V, single-phase motor (FLA = 50A per NEC Table 430.248). What is the maximum standard breaker size allowed under NEC 430.52 using an inverse time breaker?',
 '[{"label":"A","text":"60A"},{"label":"B","text":"100A"},{"label":"C","text":"125A"},{"label":"D","text":"150A"}]',
 'C',
 'NEC 430.52 allows inverse time breakers to be sized up to 250% of motor FLA for branch circuit protection. 50A x 250% = 125A. If 125A is not a standard size, round up to the next standard size — but 125A is standard, so that is the maximum allowed.',
 'hard'),

('breakers',
 'A panel has a 60A continuous load (lighting). NEC 210.20 requires the breaker to be sized at what minimum percentage of the continuous load?',
 '[{"label":"A","text":"100% — 60A breaker is sufficient"},{"label":"B","text":"110% — 66A, round up to 70A"},{"label":"C","text":"125% — 75A breaker minimum"},{"label":"D","text":"150% — 90A breaker minimum"}]',
 'C',
 'NEC 210.20(A) requires overcurrent protection for continuous loads to be rated at no less than 125% of the continuous load. 60A x 125% = 75A. This is why a 60A breaker cannot protect a 60A continuous load — you need at least a 75A breaker.',
 'medium'),

-- Lesson 3: MCCB vs MCB vs GFCI/AFCI
('breakers',
 'A customer needs to protect a 150A, 480V, 3-phase feeder to a machine tool. Which breaker type is most appropriate?',
 '[{"label":"A","text":"Miniature Circuit Breaker (MCB) — compact and cost-effective"},{"label":"B","text":"Molded Case Circuit Breaker (MCCB) — rated for the voltage and ampacity"},{"label":"C","text":"GFCI breaker — required for all 480V equipment"},{"label":"D","text":"AFCI breaker — required for all 3-phase feeders"}]',
 'B',
 'MCBs are typically rated up to 100A at lower voltages and are not suitable for 150A 480V 3-phase feeders. MCCBs are designed for higher ampacities and voltages, with adjustable trip settings available. GFCI and AFCI breakers are for specific NEC-required applications, not general industrial feeders.',
 'easy'),

('breakers',
 'A customer is finishing a garage and asks which breaker is required by NEC for all 120V, 15A and 20A receptacles in the garage.',
 '[{"label":"A","text":"Standard thermal-magnetic breaker"},{"label":"B","text":"AFCI breaker"},{"label":"C","text":"GFCI breaker"},{"label":"D","text":"Dual-function AFCI/GFCI breaker"}]',
 'C',
 'NEC 210.8 requires GFCI protection for all 120V, 15A and 20A receptacles in garages. AFCI is required in dwelling unit bedrooms and other living areas, not garages. A standard breaker alone does not meet the NEC requirement.',
 'easy'),

-- Lesson 4: Scenario — Panel Upgrade
('breakers',
 'Meridian gets a call from a plant manager. They replaced a 150kVA transformer with a 500kVA unit but kept the existing 200A MCCBs rated 22kAIC. The electrician flagged a problem. What is the issue and what should Meridian recommend?',
 '[{"label":"A","text":"The breakers are now undersized for ampacity — replace with 400A breakers"},{"label":"B","text":"The available fault current from the 500kVA transformer likely exceeds 22kAIC — recommend higher AIC-rated MCCBs or current-limiting fuses"},{"label":"C","text":"The transformer secondary voltage changed — recalibrate the electronic trip units"},{"label":"D","text":"No issue — 22kAIC is always sufficient for 480V panels"}]',
 'B',
 'A 500kVA transformer can deliver significantly higher fault current than a 150kVA unit. If available fault current now exceeds the 22kAIC breaker rating, the breakers cannot safely clear a fault. Meridian should recommend a short-circuit study and upgrade to higher AIC-rated MCCBs or add current-limiting fuses upstream.',
 'hard'),

('breakers',
 'While quoting the panel upgrade, the Meridian rep notices the customer also has a 40A continuous lighting load on a 40A breaker. How should the rep position this as an upsell?',
 '[{"label":"A","text":"No upsell needed — 40A breaker on a 40A load is correct per NEC"},{"label":"B","text":"Recommend a 50A breaker — NEC requires 125% of continuous load, so 40A x 125% = 50A minimum"},{"label":"C","text":"Recommend a 60A breaker for safety margin"},{"label":"D","text":"Continuous loads do not require derating — the 40A breaker is compliant"}]',
 'B',
 'NEC 210.20(A) requires the overcurrent device to be rated at least 125% of a continuous load. 40A x 1.25 = 50A. The existing 40A breaker is a code violation. Meridian can upsell the correct 50A breaker and position it as a compliance correction, not just a preference.',
 'medium'),

-- Lesson 5: Scenario — Motor Branch Circuit
('breakers',
 'A customer needs a branch circuit breaker for a 25HP, 460V, 3-phase motor (FLA = 34A per NEC Table 430.250). Using an inverse time breaker, what is the maximum breaker size per NEC 430.52?',
 '[{"label":"A","text":"50A"},{"label":"B","text":"70A"},{"label":"C","text":"80A"},{"label":"D","text":"90A"}]',
 'D',
 '34A x 250% = 85A. Since 85A is not a standard breaker size, NEC 430.52(C)(1) Exception No. 1 allows rounding up to the next standard size — which is 90A. This is the maximum allowed inverse time breaker for this motor.',
 'hard'),

('breakers',
 'The same customer asks if the 90A breaker can also serve as the motor disconnect required by NEC 430.109. What should the Meridian rep tell them?',
 '[{"label":"A","text":"No — NEC requires a separate disconnect; a breaker cannot serve as a disconnect"},{"label":"B","text":"Yes — NEC 430.109(C) permits a circuit breaker to serve as the motor disconnect when it is within sight of the motor or capable of being locked open"},{"label":"C","text":"Only if the breaker is rated for 3-phase service"},{"label":"D","text":"Only if a separate overload relay is installed"}]',
 'B',
 'NEC 430.109(C) explicitly permits a circuit breaker to serve as the motor disconnecting means. This is a legitimate upsell conversation — if the customer does not already have a dedicated disconnect switch, the breaker location and lockout capability may allow it to serve both functions, simplifying the installation.',
 'medium');

-- Rollback: DELETE FROM public.scenarios WHERE module = 'breakers' AND created_at::date = '2026-05-15' AND id IN (SELECT id FROM public.scenarios WHERE module = 'breakers' ORDER BY created_at DESC LIMIT 10);
