# 🤖 SSMS LaTeX Report Generation — Agent Master Prompt

> **Paste this entire prompt into your AI agent session.**
> Upload the required files listed at the bottom BEFORE sending.

---

## AGENT TASK

You are a professional LaTeX engineering report writer. Your task is to generate a **complete, compilable LaTeX report** for a final-year engineering project (PFE) called the **Smart Storage Management System (SSMS)** — a Pick/Put-to-Light warehouse management system.

The report follows the **V-Cycle (Cycle en V) methodology** for embedded/mechatronic systems engineering. It must be written in **English**, structured as a multi-file LaTeX project, and delivered as a **single `.zip` archive** containing all files needed to compile with `pdflatex` or `latexmk`.

---

## PROJECT SUMMARY (inject into report content)

- **Project name:** Smart Storage Management System (SSMS)
- **Type:** Pick/Put-to-Light warehouse bin guidance system
- **Hardware:** ESP32-WROOM-32D, WS2813 addressable RGB LEDs (36 bins × 6 LEDs = 216 total), 74HCT-series level-shifting ICs (SN74HCT244, SN74HCT245, SN74HCT573), HLK-PM01 AC/DC module, 5V/5A LED PSU
- **Firmware:** MicroPython on ESP32
- **Desktop software:** Python/Tkinter GUI packaged as Windows `.exe` via PyInstaller
- **Communication:** MQTT over local LAN (Mosquitto broker)
- **Tools used:** KiCad (schematic), LTspice (analog simulation), Proteus (digital simulation), PyInstaller
- **Libraries:** paho-mqtt, neopixel, tkinter
- **V-Cycle phases covered:** Requirements → Functional Design → Detailed Design → Implementation → Unit Test → Integration Test → Validation

---

## REPORT STRUCTURE

Generate the following chapters as **separate `.tex` files**, all included from a root `main.tex`:

### 1. `chapters/00_general_introduction.tex`
- Context of the internship / PFE
- Problem statement: manual bin-finding errors, slow picking, no real-time feedback
- Proposed solution overview (SSMS)
- Report structure description (one paragraph per chapter)
- V-Cycle methodology justification (why V-Cycle suits an embedded mechatronic project)

### 2. `chapters/01_general_context.tex` — *General Context of the Project*
- Host company / facility description (leave placeholder: `\textit{[Company Name]}`)
- Warehouse operations context: current manual process, pain points
- Project objectives (table: objective / indicator / target)
- Project scope and boundaries
- Stakeholders table
- **Bête à Cornes diagram** (draw using TikZ): Product = SSMS, User = Warehouse Operator, Goal = Reduce picking errors and improve retrieval speed
- **Octopus / Pieuvre diagram** (draw using TikZ): show FP1 (main function: guide operator to correct bin) and FC1–FC5 (constraint functions: power supply, MQTT communication, PC interface, physical mounting, safety)

### 3. `chapters/02_requirements_specification.tex` — *Spécification des Exigences*
- V-Cycle phase: **Requirements Analysis** (top-left of V)
- Use case description (actors: Operator, Administrator, System)
- Functional requirements table (FR-01 … FR-12): columns = ID / Description / Priority / Verification method
- Non-functional requirements table (NFR-01 … NFR-08): performance, reliability, usability, security
- Hardware constraints table
- Software constraints table
- Communication protocol requirements (MQTT QoS, topics: `ssms/command`, `ssms/status`)
- LED behavior specification table: state → color → pattern (Idle=off, Pending=red solid, Active=blue solid, Scanning=blue blink, Complete=green 2s then off)
- MQTT command format specification: `LED_ON:<idx>:<r>:<g>:<b>`, `LED_OFF:<idx>`, `ALL_ON`, `ALL_OFF`, `BLINK`

### 4. `chapters/03_solution_design.tex` — *Conception de la Solution*
- V-Cycle phase: **Functional Design + Detailed Design** (middle of V)

**4.1 System Architecture**
- Block diagram (TikZ): Desktop App ↔ MQTT Broker ↔ ESP32 ↔ Level Shifter ICs ↔ WS2813 LED Strip
- Power architecture diagram (TikZ): Mains → HLK-PM01 → ESP32 (3.3V); Mains → 5V/5A PSU → LEDs

**4.2 Hardware Design**
- ESP32-WROOM-32D pin assignment table
- Level-shifting circuit explanation (SN74HCT244/245/573): why 3.3V→5V conversion is needed for WS2813
- WS2813 LED strip wiring: snake topology (single GPIO), column topology (4 GPIO), row topology (9 GPIO) — advantages/disadvantages table
- Protection components: SS54/SS14 flyback diodes, SMBJ5.0A TVS, 33–100Ω series resistor on data line
- KiCad schematic description (insert `\includegraphics` placeholder for schematic export)
- Bill of Materials (BOM) table: Component / Part number / Qty / Unit cost / Total

**4.3 Firmware Design**
- MicroPython architecture: modules (`main.py`, `mqtt_handler.py`, `led_controller.py`)
- State machine diagram (TikZ): IDLE → PENDING → ACTIVE → SCANNING → COMPLETE → IDLE
- MQTT message parsing flowchart (TikZ)
- NeoPixel addressing formula: `pixel_index = bin_number * LEDS_PER_BIN + offset`

**4.4 Desktop Application Design**
- Architecture: MVC pattern, modules (`csv_mgr`, `history_mgr`, `mqtt_client`, `ui_main`)
- Workflow diagram (TikZ): Badge scan → verify operator → batch load → bin scan → part scan → completion
- GUI wireframe description (ASCII or TikZ sketch)
- CSV data model: columns, schema

**4.5 LTspice Simulation Design**
- What was simulated: level-shifter input/output waveforms, pull-up resistor sizing
- Simulation methodology

**4.6 Proteus Simulation Design**
- What was simulated: ESP32 + 74HCT573 digital behavior
- Known limitation: SN74HCT573 Proteus model behaves as 74HC (VIH ~3.5V), not HCT (VIH = 2.0V); 3.3V input shows 0V output — this is a simulator artifact, not a real hardware failure. TI datasheet is authoritative.

### 5. `chapters/04_implementation.tex` — *Réalisation et Implémentation*
- V-Cycle phase: **Implementation + Unit Tests + Integration Tests** (bottom and right of V)

**5.1 Hardware Realization**
- PCB/prototype assembly description
- Photos placeholders: `\includegraphics[width=\linewidth]{figures/hardware_photo.jpg}`
- Wiring harness and connectors

**5.2 Firmware Implementation**
- Key MicroPython code excerpts (listing environment): MQTT callback, LED state machine, BLINK handler using non-blocking timer
- GPIO configuration and NeoPixel initialization
- Unit test results table: Test ID / Description / Expected / Result / Pass/Fail

**5.3 Desktop Application Implementation**
- Tkinter window structure
- Key code excerpts: `_flash_green_then_off` non-blocking pattern using `self.after()`
- PULL (picking) workflow walkthrough with screenshots placeholders
- PUT (stocking) workflow walkthrough
- PyInstaller packaging steps

**5.4 LTspice Simulation Results**
- Waveform screenshots placeholders
- Result analysis: confirmed 3.3V→5V level shift, signal integrity at 800kHz

**5.5 Proteus Simulation Results**
- Screenshot placeholders
- Result analysis: confirmed overall digital logic (with note on VIH artifact)

**5.6 Integration Testing**
- End-to-end test table: Scenario / Steps / Expected LED behavior / Actual result / Status
- MQTT communication test results
- Latency measurements (LED response time from command publish to LED change)

**5.7 Validation against Requirements**
- Requirements traceability matrix (RTM): FR-ID / Requirement description / Test method / Test result / Status
- V-Cycle validation closure diagram reference

### 6. `chapters/05_general_conclusion.tex`
- Summary of achievements vs. objectives
- V-Cycle phase completion status table
- Difficulties encountered and solutions
- Limitations of current implementation
- Future work: ERP integration, multi-rack MQTT, mobile app, RFID instead of barcodes
- Personal learning reflection

### 7. `chapters/06_annexes.tex`
- Annex A: Full BOM with supplier links (table)
- Annex B: Complete MicroPython `main.py` source code (listings)
- Annex C: Complete Python desktop app `main.py` source code (listings)
- Annex D: MQTT topic and command reference table
- Annex E: KiCad schematic (full-page figure placeholder)
- Annex F: LTspice netlist
- Annex G: Acronyms and abbreviations table
- Annex H: References (IEEE format, minimum 10 references including: Hercog et al., Sensors 2022, DOI: 10.3390/s22249769)

---

## FILE STRUCTURE TO GENERATE

```
SSMS_Report/
├── main.tex                    # Root file: preamble, \include all chapters
├── references.bib              # BibTeX file with all references
├── figures/                    # Empty folder with .gitkeep + README
│   └── README.txt              # Instructions for placing figures
├── chapters/
│   ├── 00_general_introduction.tex
│   ├── 01_general_context.tex
│   ├── 02_requirements_specification.tex
│   ├── 03_solution_design.tex
│   ├── 04_implementation.tex
│   ├── 05_general_conclusion.tex
│   └── 06_annexes.tex
├── styles/
│   └── ssms_style.sty          # Custom LaTeX style file
└── compile.sh                  # Shell script: latexmk -pdf main.tex
```

---

## LaTeX REQUIREMENTS

### `main.tex` must include:
- Document class: `\documentclass[12pt,a4paper]{report}`
- Packages: `geometry`, `graphicx`, `hyperref`, `booktabs`, `longtable`, `listings`, `xcolor`, `tikz`, `pgfplots`, `amsmath`, `amssymb`, `fancyhdr`, `titlesec`, `tocloft`, `babel[english]`, `biblatex` (or `natbib`), `appendix`, `fontenc[T1]`, `inputenc[utf8]`, `microtype`, `caption`, `subcaption`, `float`, `multirow`, `tabularx`, `enumitem`, `glossaries`
- TikZ libraries: `arrows.meta`, `shapes.geometric`, `positioning`, `fit`, `backgrounds`, `calc`
- Custom colors: SSMS brand palette — `ssmsBlue` (#1A73E8), `ssmsGreen` (#34A853), `ssmsRed` (#EA4335), `ssmsOrange` (#FBBC04), `ssmsDark` (#1C1C1E), `ssmsGray` (#F5F5F5)
- Header/footer via `fancyhdr`: left = chapter name, right = "SSMS — PFE Report", footer = page number
- Cover page: University logo placeholder, project title, student name placeholder, supervisor name placeholder, academic year placeholder
- Table of contents, list of figures, list of tables, list of listings
- `\includeonly`-compatible structure

### Code listings style:
```latex
\lstset{
  basicstyle=\ttfamily\small,
  keywordstyle=\color{ssmsBlue}\bfseries,
  commentstyle=\color{ssmsGreen}\itshape,
  stringstyle=\color{ssmsRed},
  numbers=left, numberstyle=\tiny,
  breaklines=true, frame=single,
  backgroundcolor=\color{ssmsGray}
}
```

### TikZ diagrams required (generate actual TikZ code, not placeholders):
1. **V-Cycle methodology diagram** (in `main.tex` or intro chapter): two sides of the V with phase labels and arrows showing the SSMS project phases
2. **Bête à Cornes** (Chapter 1): standard 3-box diagram
3. **Pieuvre / Octopus** (Chapter 1): central oval with FP and FC branches
4. **System architecture block diagram** (Chapter 3)
5. **Power architecture diagram** (Chapter 3)
6. **LED state machine** (Chapter 3): state transition diagram
7. **MQTT message flowchart** (Chapter 3)
8. **Desktop app workflow** (Chapter 3): swimlane or flowchart

---

## STYLE FILE `styles/ssms_style.sty`

Define:
- Chapter title formatting (large, colored, with rule underline)
- Custom `\requirement{id}{description}{priority}` command for requirements
- Custom `\ssmsNote{text}` box (blue left-border info box using `tcolorbox` or `mdframed`)
- Custom `\vcyclephase{name}` header banner for each chapter indicating V-Cycle position

---

## `references.bib` — REQUIRED ENTRIES (generate full BibTeX)

Include at minimum:
1. Hercog et al., Sensors, 2022, DOI: 10.3390/s22249769 (pick-to-light systems review)
2. ESP32 Technical Reference Manual, Espressif Systems, 2023
3. WS2813 datasheet, Worldsemi, 2019
4. SN74HCT573 datasheet, Texas Instruments, 2022
5. HLK-PM01 datasheet, Hi-Link, 2020
6. OASIS MQTT specification v3.1.1, 2014
7. MicroPython documentation, micropython.org, 2023
8. PyInstaller documentation, 2023
9. KiCad EDA documentation, 2023
10. At least 2 academic references on warehouse management systems or Industry 4.0

---

## OUTPUT INSTRUCTIONS

1. Generate every `.tex` file completely — no "// TODO" placeholders in the LaTeX content itself. Use `\textit{[Photo placeholder: hardware\_photo.jpg]}` only for actual photographs the student must supply.
2. All TikZ diagrams must be fully coded and compilable.
3. The `references.bib` must have valid BibTeX syntax.
4. Package the entire `SSMS_Report/` folder as `SSMS_Report.zip`.
5. Confirm which files are included in the zip and state the compile command.

---

## 📎 WHAT TO UPLOAD TO THE AGENT FOR BEST RESULTS

Upload these files **before sending this prompt** for maximum accuracy and personalization:

| # | File | Why it helps |
|---|------|-------------|
| 1 | **Your KiCad schematic export** (PDF or PNG) | Agent can describe real component placement, net names, and reference designators accurately |
| 2 | **Your `main.py` firmware file(s)** (MicroPython) | Agent generates accurate code listings and correct state machine from real code |
| 3 | **Your desktop app `main.py`** (Python/Tkinter) | Agent documents actual GUI structure, workflow logic, and MQTT calls |
| 4 | **LTspice screenshot(s)** (PNG) | Agent can describe waveform results concretely instead of generically |
| 5 | **Proteus simulation screenshot(s)** (PNG) | Agent documents real simulation outcome including the HCT VIH artifact |
| 6 | **Your BOM spreadsheet** (CSV or XLSX) | Agent generates an accurate BOM table with real part numbers and prices |
| 7 | **Your university report template** (DOCX or PDF, if any) | Agent can match required formatting, margins, cover page style |
| 8 | **Any existing report sections you've written** (DOCX/PDF/TXT) | Agent preserves your existing text and avoids contradicting it |
| 9 | **Supervisor name / university name / academic year** (text message) | Agent fills cover page correctly |
| 10 | **Company/facility name and brief description** (text message) | Agent fills Chapter 1 company context accurately |

> **Minimum viable upload:** Files #2, #3, and a text message with your name, university, supervisor, and company name will already give the agent enough to generate a very strong report.

---

*Prompt version: 1.0 — SSMS PFE LaTeX Report — V-Cycle methodology — English*