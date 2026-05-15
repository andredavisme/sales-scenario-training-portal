-- Module 4 Extended Seed: Motor Starters Deep Dive
-- 5 lessons, 10 exercises
-- Applied: 2026-05-15

INSERT INTO public.scenarios (module, prompt, choices, answer, explanation, difficulty) VALUES

-- Lesson 1: Starter Fundamentals
('starters',
 'A customer asks what the functional difference is between a full-voltage non-reversing (FVNR) starter and a full-voltage reversing (FVR) starter. What is the most accurate answer?',
 '[{"label":"A","text":"FVR starters use a larger contactor to handle higher inrush current"},{"label":"B","text":"FVR starters contain two contactors wired with interlocks so swapping any two motor leads reverses rotation"},{"label":"C","text":"FVR starters include a built-in soft-start ramp to reduce mechanical shock during reversal"},{"label":"D","text":"FVR starters are only used on single-phase motors"}]',
 'B',
 'A full-voltage reversing starter uses two contactors — forward and reverse — wired with both mechanical and electrical interlocks to prevent simultaneous energization. When the reverse contactor is energized, any two motor leads are swapped, reversing the phase sequence and motor rotation. There is no soft-start ramp; that is a separate product category.',
 'easy'),

('starters',
 'A customer is selecting an overload relay for a 15HP, 460V, 3-phase motor (FLA = 21A). They ask whether to use a bimetallic or electronic overload relay. What is the strongest selling point of the electronic overload relay?',
 '[{"label":"A","text":"Electronic overload relays are less expensive than bimetallic types"},{"label":"B","text":"Electronic overload relays provide adjustable trip class, phase loss detection, and ground fault protection in one device"},{"label":"C","text":"Bimetallic relays are no longer NEC-compliant for motors above 10HP"},{"label":"D","text":"Electronic overload relays do not require manual reset after a trip"}]',
 'B',
 'Electronic overload relays offer significant advantages over bimetallic types: adjustable trip class (Class 10, 20, 30), phase loss and phase imbalance detection, ground fault protection, and often a communications port for diagnostics. These features make them the preferred choice for critical or high-value motors despite the higher upfront cost.',
 'medium'),

-- Lesson 2: Overload Sizing
('starters',
 'A customer needs to set the overload relay for a 20HP, 460V, 3-phase motor with a nameplate FLA of 27A and a 1.15 service factor. Per NEC 430.32(A)(1), what is the maximum overload relay setting?',
 '[{"label":"A","text":"27A"},{"label":"B","text":"31.05A (115% of FLA)"},{"label":"C","text":"33.75A (125% of FLA)"},{"label":"D","text":"40.5A (150% of FLA)"}]',
 'C',
 'NEC 430.32(A)(1) permits overload protection set at no more than 125% of nameplate FLA for motors with a service factor of 1.15 or greater. 27A x 1.25 = 33.75A. This is the maximum allowed overload setting for this motor.',
 'hard'),

('starters',
 'A customer''s overload relay keeps tripping on a conveyor motor that runs fine under normal load. The motor nameplate shows FLA = 18A and the overload is set to 18A. What should Meridian recommend?',
 '[{"label":"A","text":"Replace the motor — it is drawing too much current"},{"label":"B","text":"Check the actual running current with a clamp meter; if below FLA, increase the overload setting up to 125% of FLA per NEC 430.32"},{"label":"C","text":"Bypass the overload relay to stop nuisance tripping"},{"label":"D","text":"Switch to a Class 30 trip curve immediately"}]',
 'B',
 'Setting the overload exactly at nameplate FLA leaves no margin for normal temperature variation and slight current fluctuation. NEC 430.32 permits setting up to 125% of FLA for motors with a qualifying service factor. Meridian should recommend measuring actual running current first, then adjusting to the NEC-permitted maximum if the motor is running within nameplate ratings. Bypassing an overload relay is never acceptable.',
 'medium'),

-- Lesson 3: Soft Starters
('starters',
 'A customer runs a centrifugal pump and experiences water hammer and pipe stress each time the motor starts. What should Meridian recommend?',
 '[{"label":"A","text":"A larger FVNR starter — more contact area reduces inrush current"},{"label":"B","text":"A soft starter — it ramps voltage up gradually, reducing inrush current and mechanical shock during start"},{"label":"C","text":"A reversing starter — brief reverse rotation before forward start reduces water hammer"},{"label":"D","text":"A higher service factor motor — it handles inrush better"}]',
 'B',
 'Soft starters ramp the voltage (and therefore torque) up gradually during start, reducing inrush current and eliminating the mechanical shock that causes water hammer in pump systems. They are the standard recommendation for pump and fan applications where full-voltage starting causes system stress.',
 'easy'),

('starters',
 'A customer asks whether a soft starter provides energy savings during normal running operation on a lightly loaded motor. What is the accurate answer?',
 '[{"label":"A","text":"Yes — soft starters continuously optimize voltage to reduce motor losses at all loads"},{"label":"B","text":"No — soft starters bypass the SCRs after start and run the motor at full voltage; energy savings are limited to reduced mechanical wear"},{"label":"C","text":"Yes — soft starters reduce frequency during light load to save energy"},{"label":"D","text":"Soft starters save the same amount of energy as a VFD at all operating points"}]',
 'B',
 'Most soft starters include an internal bypass contactor that engages after the motor reaches full speed, connecting the motor directly to line voltage. At that point the SCRs are out of the circuit and there is no ongoing voltage reduction or energy savings. Energy savings come from reduced mechanical stress and fewer motor restarts, not from running efficiency. Only a VFD provides true variable-speed energy savings.',
 'medium'),

-- Lesson 4: Scenario — Starter Selection
('starters',
 'A customer needs to start a 50HP, 460V, 3-phase air compressor under full load torque. The electrical system has limited inrush capacity. What should Meridian recommend?',
 '[{"label":"A","text":"FVNR starter — simplest and least expensive"},{"label":"B","text":"Soft starter — reduces inrush while maintaining enough torque to start under load"},{"label":"C","text":"FVR starter — reversing capability provides better torque control"},{"label":"D","text":"Part-winding starter — always the best choice for compressors"}]',
 'B',
 'A soft starter reduces inrush current (addressing the electrical system concern) while still delivering enough torque to start a compressor under load. An FVNR starter provides full inrush. Part-winding starters reduce inrush but require a motor specifically wound for part-winding starting. VFDs are an alternative but more expensive when speed control is not needed.',
 'medium'),

('starters',
 'The same customer asks about NEMA vs IEC starter sizing. Their maintenance team prefers interchangeable replacement parts. What should Meridian explain?',
 '[{"label":"A","text":"NEMA starters are physically larger but use standardized frame sizes that simplify replacement in North American facilities"},{"label":"B","text":"IEC starters are always superior and should replace all NEMA starters"},{"label":"C","text":"NEMA and IEC starters are fully interchangeable with no differences"},{"label":"D","text":"NEMA starters cannot be used with electronic overload relays"}]',
 'A',
 'NEMA starters use standardized size designations (Size 0 through Size 9) that make replacement straightforward — a maintenance team knows a Size 3 is always a Size 3. IEC starters are more compact and cost-effective but are application-rated, requiring exact model matching for replacement. For facilities prioritizing interchangeable spares, NEMA is the easier choice.',
 'medium'),

-- Lesson 5: Scenario — Troubleshooting
('starters',
 'A customer calls: a FVNR starter contactor is chattering (buzzing) when energized. What is the most likely cause?',
 '[{"label":"A","text":"The motor is overloaded — replace with a larger motor"},{"label":"B","text":"Control voltage is low or the shading ring on the magnet face is broken — check control voltage and inspect the contactor magnet"},{"label":"C","text":"The overload relay is set too high — reduce the setting"},{"label":"D","text":"The contactor coil is the wrong voltage — replace with a 480V coil"}]',
 'B',
 'Contactor chattering has two common causes: (1) control voltage dropping below the contactor minimum pick-up voltage, causing the magnet to partially drop out and re-energize rapidly, or (2) a broken shading ring on the AC magnet face. The shading ring maintains continuous magnetic force through the AC cycle — without it, the magnet chatters at line frequency. Inspect both before recommending replacement.',
 'medium'),

('starters',
 'A customer''s motor starter trips on overload within 30 seconds of each start, but the motor runs fine if restarted immediately after the overload cools. The overload is correctly set at 125% FLA. What is the most likely cause?',
 '[{"label":"A","text":"The overload relay is faulty and should be replaced"},{"label":"B","text":"The motor is starting too frequently — thermal memory in the overload relay is accumulating heat from successive starts"},{"label":"C","text":"The motor service factor is too low for this application"},{"label":"D","text":"The branch circuit breaker is interfering with the overload relay"}]',
 'B',
 'Bimetallic and electronic overload relays retain thermal memory from previous starts. If a motor is started too frequently, the accumulated heat in the relay''s thermal model reaches the trip threshold even though each individual start looks normal. The fix is to reduce start frequency, add a start inhibit timer, or upgrade to an electronic overload relay with adjustable thermal memory reset.',
 'hard');

-- Rollback: DELETE FROM public.scenarios WHERE module = 'starters' AND created_at::date = '2026-05-15' AND id IN (SELECT id FROM public.scenarios WHERE module = 'starters' ORDER BY created_at DESC LIMIT 10);
