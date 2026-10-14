# default_frame/

Formale Seiten der Arbeit, eingebunden aus `1Main.tex` per `\input`.

| Datei | Zweck |
|---|---|
| `Titelseite.tex` | Titelseite mit Signet; setzt `\pagenumbering{Roman}`; liest alles aus `metadata.tex` |
| `Inhaltsverzeichnis.tex` | `\tableofcontents` |
| `Abbildungsverzeichnis.tex` / `Tabellenverzeichnis.tex` | `\listoffigures` / `\listoftables` |
| `Abkuerzungsverzeichnis.tex` | `\printglossary[type=acronym]` |
| `Glossar.tex` | `\printglossary[type=main]` im Anhang |
| `Literaturverzeichnis.tex` | `\printbibliography` (ohne Kategorie `abbildung`) |
| `SelbststaendigkeitserklaerungUniBwM.tex` | Eidesstattliche Erklärung mit `\mytitle`, `\myplace`, `\timeend` |

## Muster

- Verzeichnisseiten: `\clearpage\cleardoublepage`, dann Gruppe mit neutralisiertem `\clearpage`,
  `\verzeichnislogo` (Makro in `default_style/layout.tex`), danach der eigentliche Befehl.
- Keine Namen, Titel, Daten oder Orte hart eintragen – Makros aus `metadata.tex` nutzen.
- Optionale Felder mit `\ifdefempty{\feld}{}{…}` (etoolbox, über biblatex geladen) ausblenden.

## Gotchas

- In `tabular` keine bedingten Zeilen direkt mit `&` im `\ifdefempty`-Argument – vorher in ein Makro
  legen (siehe Betreuer-Zeilen in `Titelseite.tex`).
- Die Inhalte (Glossar-Einträge, Aufgabenstellung) liegen in `content/allgemein/`, nicht hier.
- `*.aux` in diesem Ordner sind Reste des früheren `\include` und ignoriert.
