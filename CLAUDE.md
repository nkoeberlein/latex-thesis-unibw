# latex-vorlage-unibw-inf

LuaLaTeX-Vorlage (KOMA `scrreprt`) für Bachelor-/Master-/Seminararbeiten an der UniBw München.
Schwesterprojekt: Typst-Version unter `../wissenschaftlArbeit_UniBw_typst` (GitHub `typst-thesis-unibw`) –
Layout, Metadaten-Felder und Schalter sind bewusst parallel gehalten.

## Einstiegspunkte

- `1Main.tex` – Hauptdokument: Schalter `\ifisprint` / `\ifisdraft`, Kapitelreihenfolge, Verzeichnisse
- `metadata.tex` – alle persönlichen Angaben (`\myname`, `\mytitle`, `\myprofessur`, `\myplace`, …)
- `Skript.tex` – Exposé/Ideenskizze, nutzt dieselben Styles und Metadaten

## Verzeichnisse

| Ordner | Zweck |
|---|---|
| `default_style/` | Klasse, Pakete, Layout, Farben – siehe dortige CLAUDE.md |
| `default_frame/` | Titelseite, Verzeichnisse, Erklärung |
| `content/` | Kapitel und Frontmatter-Inhalte (Abstract, Aufgabenstellung, Glossar-Einträge) |
| `bibliography/` | `references.bib` (biblatex/Biber, `numeric`) |
| `fonts/` | Bookerly, wird per `Path = fonts/` geladen |
| `docus/` | Installationsanleitung, Cheatsheets |
| `.claude/skills/` | `latex-compile`, `latex-review`, `bibliography` |

## Build

```bash
latexmk 1Main.tex    # .latexmkrc: lualatex --shell-escape + biber + makeglossaries
./compile.sh         # Wrapper, --fast für 1× LuaLaTeX
```

## Gotchas

- Nur LuaLaTeX (fontspec, unicode-math); `--shell-escape` ist Pflicht für minted.
- Lokal ist **kein TeX installiert** und soll auch nicht installiert werden – Änderungen über CI prüfen
  (`.github/workflows/build.yml`, PDFs als Artefakt `pdf`).
- Schalter müssen **vor** `\input{default_style/load_all}` stehen; `setup.tex` legt Standardwerte an,
  falls ein Dokument (z. B. `Skript.tex`) sie nicht definiert.
- `\makeglossaries` steht nur in `1Main.tex`, nach allen `\newglossary` in `layout.tex`.
- Schriften für Überschriften/Captions nur in `layout.tex` setzen (`\addtokomafont` hängt an, mehrfaches Setzen überschreibt sich).
- Optionale Metadaten (`\reviewertwo`, `\advisor`) leer → werden per `\ifdefempty` ausgeblendet.
- Hardcodierte Namen/Daten in `default_frame/` vermeiden – immer Makros aus `metadata.tex` verwenden.
