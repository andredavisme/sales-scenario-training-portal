-- Module 5 Extended Seed: Industrial Controls Deep Dive
-- 5 lessons, 10 exercises
-- Applied: 2026-05-15

INSERT INTO public.scenarios (module, prompt, choices, answer, explanation, difficulty) VALUES

-- Lesson 1: Control Circuit Fundamentals
('controls',
 'A customer asks why industrial control circuits use 120VAC control voltage instead of running the contactor coil directly from the 480V motor circuit. What is the best answer?',
 '[{"label":"A","text":"120VAC coils are less expensive than 480VAC coils"},{"label":"B","text":"120VAC control circuits reduce shock hazard for personnel working on control wiring and allow use of standard pilot devices rated for 120VAC"},{"label":"C","text":"480VAC cannot be used for control circuits per NEC"},{"label":"D","text":"120VAC control voltage reduces motor inrush current"}]',
 'B',
 '120VAC control circuits are the North American industrial standard primarily for safety — lower voltage reduces electrocution risk when technicians work on control wiring. It also allows use of widely available, low-cost pilot devices (pushbuttons, selector switches, limit switches) all rated 120VAC. 480VAC control is permitted by NEC but uncommon in North America due to the safety concern.',
 'easy'),

('controls',
 'A customer wants to understand the difference between a normally open (NO) and normally closed (NC) contact on a pushbutton. Which statement is correct?',
 '[{"label":"A","text":"A NO contact passes current when the button is not pressed; an NC contact passes current when the button is pressed"},{"label":"B","text":"A NO contact passes current only when the button is pressed; an NC contact passes current when the button is not pressed"},{"label":"C","text":"NO and NC refer to the voltage level, not the switching state"},{"label":"D","text":"NC contacts are only used on emergency stop buttons"}]',
 'B',
 'By definition: a normally open (NO) contact is open (no current) in the de-energized/unpressed state and closes when actuated. A normally closed (NC) contact is closed (passing current) in the de-energized/unpressed state and opens when actuated. This is foundational to all control circuit design.',
 'easy'),

-- Lesson 2: 3-Wire Control and Latching
('controls',
 'A maintenance tech wired a motor starter with only a START pushbutton (NO) and a STOP pushbutton (NC) in series with the coil. The motor starts when START is pressed but stops as soon as the button is released. What is missing?',
 '[{"label":"A","text":"A second STOP button for redundancy"},{"label":"B","text":"A holding contact (auxiliary NO contact on the contactor) wired in parallel with the START button to maintain the circuit after the START button is released"},{"label":"C","text":"An overload relay contact in the control circuit"},{"label":"D","text":"A control transformer to step down to 120VAC"}]',
 'B',
 'This is the classic 3-wire control circuit. A holding contact — an auxiliary normally open contact on the contactor itself — is wired in parallel with the START pushbutton. When the contactor energizes, the auxiliary contact closes and maintains the control circuit after the START button is released. This is also called a seal-in or latch circuit.',
 'medium'),

('controls',
 'In a standard 3-wire STOP-START motor control circuit, what happens to the motor if a momentary power loss occurs and power is then restored?',
 '[{"label":"A","text":"The motor automatically restarts when power returns"},{"label":"B","text":"The motor remains stopped — the holding contact dropped out during the power loss and must be re-energized by pressing START again"},{"label":"C","text":"The overload relay trips to prevent automatic restart"},{"label":"D","text":"The motor restarts only if the STOP button is pressed first"}]',
 'B',
 '3-wire control provides low-voltage protection (LVP). When power is lost, the contactor de-energizes and the holding contact opens. When power returns, the control circuit is open at the holding contact — the motor will not restart until the operator presses START again. This is a critical safety feature that prevents unexpected machine restart after a power interruption.',
 'medium'),

-- Lesson 3: Pilot Devices and Indicators
('controls',
 'A customer is specifying a pilot light to indicate when a 480V motor is running. They ask whether to use a transformer-type or resistor-type pilot light. What should Meridian recommend for a 120VAC control circuit?',
 '[{"label":"A","text":"Resistor-type — simpler and no transformer needed for 120VAC circuits"},{"label":"B","text":"Transformer-type — always required regardless of control voltage"},{"label":"C","text":"Either type works for 120VAC; transformer-type is preferred for 480VAC direct connection; resistor-type is standard for 120VAC control circuits"},{"label":"D","text":"LED pilot lights cannot be used on 120VAC circuits"}]',
 'C',
 'For 120VAC control circuits, resistor-type or direct LED pilot lights are standard and cost-effective. Transformer-type pilot lights are used when connecting directly to 480VAC or higher voltages, stepping the voltage down to the lamp rated voltage. On a 120VAC control circuit, a transformer-type light is unnecessary and adds cost.',
 'easy'),

('controls',
 'A customer wants a selector switch that allows a machine to run in either HAND (manual) or AUTO (automatic/PLC-controlled) mode, with an OFF position in between. How many positions does this selector switch need?',
 '[{"label":"A","text":"2-position: HAND and AUTO"},{"label":"B","text":"3-position: HAND — OFF — AUTO"},{"label":"C","text":"4-position: OFF — HAND — AUTO — REMOTE"},{"label":"D","text":"A selector switch cannot be used for HAND/AUTO selection — use a PLC input instead"}]',
 'B',
 'A 3-position selector switch (HAND — OFF — AUTO) is the standard for HOA (Hand-Off-Auto) control, one of the most common control circuit configurations in industrial and HVAC applications. The OFF position provides a positive de-energized state between the two run modes, which is important for safety and troubleshooting.',
 'easy'),

-- Lesson 4: Scenario — E-Stop Circuit
('controls',
 'A customer is designing a safety circuit and asks where the E-stop (emergency stop) button contact should be wired in the control circuit. What is the correct answer?',
 '[{"label":"A","text":"In parallel with the START button so it can override the start signal"},{"label":"B","text":"In series in the control circuit so that opening the E-stop contact breaks the entire control circuit and de-energizes all contactors"},{"label":"C","text":"Directly in the motor power circuit to interrupt the motor leads"},{"label":"D","text":"Connected to the PLC input only — the PLC handles the stop logic"}]',
 'B',
 'E-stop contacts (NC type) are wired in series in the control circuit. Opening the E-stop breaks the control circuit, de-energizing all downstream contactors and stopping all controlled motion. Wiring the E-stop only to a PLC input is not a hardwired safety stop — it depends on PLC software execution and does not meet NFPA 79 or ISO 13849 hardwired safety requirements for most machine applications.',
 'medium'),

('controls',
 'A customer has four E-stop buttons around a large machine. How should they be wired to ensure any single E-stop press stops the machine?',
 '[{"label":"A","text":"Wire all four E-stop NC contacts in parallel — any one opening breaks the circuit"},{"label":"B","text":"Wire all four E-stop NC contacts in series — any one opening breaks the entire control circuit"},{"label":"C","text":"Connect each E-stop to a separate PLC input and let the PLC handle the stop logic"},{"label":"D","text":"Use NO E-stop contacts and wire them in series so any press completes the stop circuit"}]',
 'B',
 'NC E-stop contacts wired in series is the correct and required approach. With all four contacts in series, opening any single contact (pressing any E-stop) breaks the series circuit and de-energizes the contactor. Wiring in parallel would require ALL buttons to be pressed simultaneously to stop the machine — the opposite of the intent. NC contacts in series = any one press stops the machine.',
 'medium'),

-- Lesson 5: Scenario — Control Circuit Troubleshooting
('controls',
 'A customer reports that a motor will not start. The STOP button is released (NC contact closed), the overload relay has been reset, and the START button is pressed but the contactor does not energize. Control power is confirmed ON at L1 and L2 of the control transformer. What is the recommended first diagnostic step?',
 '[{"label":"A","text":"Replace the contactor coil immediately"},{"label":"B","text":"Use a voltmeter to trace the control circuit from the control transformer secondary, checking voltage at each series element (STOP contact, OL contact, START contact) to find where voltage is lost"},{"label":"C","text":"Replace the START pushbutton — it is the most common failure point"},{"label":"D","text":"Check the motor winding resistance with a megohmmeter"}]',
 'B',
 'Voltage tracing is the systematic approach to control circuit troubleshooting. With control power confirmed, measure voltage at each node in the series circuit: after the STOP contact, after the OL contact, after the START contact, and at the coil terminals. The point where voltage disappears identifies the open element. This approach finds the fault in minutes without unnecessary parts replacement.',
 'medium'),

('controls',
 'A customer installed a new pushbutton station and the motor now runs without pressing START — it energizes as soon as control power is applied. What wiring error most likely occurred?',
 '[{"label":"A","text":"The overload relay contact is wired in parallel instead of series"},{"label":"B","text":"The START pushbutton was wired as NC instead of NO, completing the control circuit without being pressed"},{"label":"C","text":"The holding contact auxiliary wire was omitted"},{"label":"D","text":"The STOP button was wired as NO instead of NC"}]',
 'B',
 'If the START pushbutton is wired using its NC contact instead of its NO contact, the control circuit is completed as soon as control power is applied — the contactor energizes without pressing anything. This is a common wiring error when installers confuse the NO and NC terminals on a pushbutton. The fix is to move the wire to the correct NO terminal.',
 'medium');
