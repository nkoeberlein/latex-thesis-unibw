---
name: latex-compile
description: Analyzes LaTeX compilation errors and fixes them. Use when LaTeX doesn't compile or warnings occur, the user says "/latex-compile".
---

# Fix LaTeX Compilation Errors

## Step 1: Analyze errors
Read log file (`.log`) or evaluate error message.

Common error types:
```
! Undefined control sequence    → Typo in \command or missing import
! Missing $ inserted            → Math symbol outside math mode
! File 'package.sty' not found  → \usepackage{package} missing or not installed
! Missing { inserted            → Brace not closed
Undefined references            → \label missing or need to compile twice
Citation 'key' undefined        → BibTeX/Biber not yet executed
```

## Step 2: Check compilation order
This template requires **LuaLaTeX** (fontspec, Bookerly, minted with `--shell-escape`).
Main file is `1Main.tex` (exposé: `Skript.tex`).

```bash
latexmk 1Main.tex          # uses .latexmkrc: lualatex + biber + makeglossaries
```

Manual order if latexmk is unavailable:
```bash
lualatex --shell-escape 1Main.tex
makeglossaries 1Main
biber 1Main
lualatex --shell-escape 1Main.tex
lualatex --shell-escape 1Main.tex
```

## Step 3: Implement fix
Concrete fix for the identified error.

## Step 4: Verification
Compile again and check if the error is resolved.
Check warnings (Overfull \hbox, Underfull \vbox).
