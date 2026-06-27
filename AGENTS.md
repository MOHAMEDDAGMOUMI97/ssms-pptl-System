# AGENTS.md — OC-SSMS-LATEX (PFE Report)

## Project Overview
LaTeX report for PFE (Final Year Project) in Mechatronics: **Smart Storage Management System (SSMS) — Pick/Put-to-Light Warehouse Guidance System**.

**Root for build commands:** `SSMS_Report/`

## Build Commands
```bash
cd SSMS_Report
./compile.sh                    # uses latexmk -pdf main.tex
# or directly:
latexmk -pdf main.tex
```
- Uses `latexmk` with `bibtex_use = 2` (biber backend for biblatex)
- Output: `main.pdf` in `SSMS_Report/`
- Clean: `latexmk -c` (aux files) or `latexmk -C` (all generated)

## Structure
```
SSMS_Report/
├── main.tex              # Main entry point
├── compile.sh            # Build script (latexmk -pdf main.tex)
├── .latexmkrc            # latexmk config (biber backend)
├── ssms_style.sty        # Custom style package
├── references.bib        # Bibliography (biblatex/biber)
├── chapters/             # Chapter files (00–06)
├── figures/              # Figures (PDF/PNG/SVG)
└── SSMS_Report.zip       # Pre-built archive
```

## Build Requirements
- TeX Live / MiKTeX with: `latexmk`, `biber`, `biblatex`, `pgfplots`, `tikz`, `biblatex-ieee`
- Required packages listed in `main.tex` preamble (lines 3–39)

## Build Notes
- Uses `biblatex` with `backend=biber` (not bibtex) — requires `biber` installed
- Custom style: `\usepackage{ssms_style}` (loads `ssms_style.sty`)
- Bibliography: `\addbibresource{references.bib}` + `\printbibliography`
- Figures path: `\graphicspath{{figures/}}`
- Chapters included via `\include{chapters/XX_name}`

## Common Tasks
```bash
# Full build (PDF + bibliography)
cd SSMS_Report && latexmk -pdf main.tex

# Quick compile (no biblio update)
cd SSMS_Report && pdflatex main.tex

# Clean aux files
cd SSMS_Report && latexmk -c

# Full clean
cd SSMS_Report && latexmk -C

# View PDF (Linux/macOS)
cd SSMS_Report && xdg-open main.pdf  # or open on macOS
```

## Repository Notes
- Root is `OC-SSMS-LATEX/` but build runs from `SSMS_Report/`
- Pre-built `SSMS_Report.zip` exists at repo root
- Chapter files in `chapters/` use `\include` (not `\input`) — enables `\includeonly`
- Bibliography uses `biblatex` + `biber` (IEEE style)
- Custom colors defined in `main.tex` (lines 35–40): `ssmsBlue`, `ssmsGreen`, etc.
- TikZ libraries loaded: `arrows.meta, shapes.geometric, positioning, fit, backgrounds, calc`

## Do Not
- Do not run build commands from repo root — must `cd SSMS_Report` first
- Do not use `bibtex` — bibliography uses `biber` backend
- Do not edit `ssms_style.sty` unless modifying shared styles
- Do not commit build artifacts (`main.pdf`, `.aux`, `.bbl`, `.bcf`, `.fdb_latexmk`, `.fls`, `.log`, `.out`, `.toc`, `.bbl`, `.run.xml`)

## References
- `SSMS_Report/main.tex` — main entry, preamble, structure
- `SSMS_Report/.latexmkrc` — latexmk config
- `SSMS_Report/compile.sh` — build script
- `SSMS_Report/ssms_style.sty` — custom styles