---
name: latex-review
description: Reviews a LaTeX document for structure, style, and common errors. Use when the user wants to review a LaTeX document, says "/latex-review".
---

# LaTeX Document Review

## Step 1: Read document structure
- Read main file (main.tex / thesis.tex)
- Check document class and used packages
- Understand chapter structure and outline

## Step 2: Check references and labels
- All `\label{...}` defined and correct?
- All `\ref{...}` and `\cite{...}` have corresponding definitions?
- Duplicate labels (`\label{...}` identical twice)?
- Check `.bib` file for complete entries

## Step 3: Common LaTeX errors
- Figures/tables without `\caption`?
- `\begin{figure}` without `\label` (not referenceable)?
- Inconsistent language in `babel`/`polyglossia`?
- Missing `\listoffigures`, `\listoftables` when expected?

## Step 4: Typographic conventions (German)
- Em dash: `--` (not `-` or `---`)
- Quotation marks: `\glqq...\grqq{}` or csquotes `\enquote{}`
- Non-breaking space: `~` before numbers and references (`Fig.~\ref{...}`)
- Ellipsis: `\dots` instead of `...`
- Units of measurement: recommend siunitx package

## Step 5: Consistency
- Terminology consistent throughout?
- Formatting style consistent (italics for technical terms, etc.)?

## Step 6: Prioritized report
With line number references and concrete fixes
