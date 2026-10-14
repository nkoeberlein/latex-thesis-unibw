---
name: bibliography
description: Manages bibliography entries in BibTeX/BibLaTeX files. Use when the user wants to add, check, or correct sources, says "/bibliography".
---

# Manage Bibliography

## Step 1: Analyze .bib file
- Read existing .bib file
- Identify the system used: BibTeX or BibLaTeX (biblatex package)?
- Check citation style (numeric, authoryear, alphabetic...)?

## Step 2: Create new entry
Required fields by type:

```bibtex
@article{key,
  author  = {LastName, FirstName and LastName2, FirstName2},
  title   = {Title of the Article},
  journal = {Journal Name},
  year    = {2024},
  volume  = {42},
  pages   = {1--10},
  doi     = {10.xxxx/...}
}

@book{key,
  author    = {LastName, FirstName},
  title     = {Book Title},
  publisher = {Publisher},
  year      = {2024},
  address   = {City}
}

@online{key,
  author  = {LastName, FirstName},
  title   = {Page Title},
  url     = {https://...},
  urldate = {2024-01-15},
  year    = {2024}
}
```

## Step 3: Quality check
- DOI present if available?
- Consistent format: first names spelled out or abbreviated?
- Duplicates (same source with different keys)?
- Special characters correctly escaped (`ü` → `{\"u}` or UTF-8)?

## Step 4: Citation in text
- `\cite{key}` – Standard citation
- `\textcite{key}` – "Author (Year)" in biblatex
- `\autocite{key}` – Style-dependent in biblatex
- `\parencite{key}` – "(Author, Year)" in biblatex
