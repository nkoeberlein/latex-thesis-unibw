# default_style/

Präambel der Vorlage. `load_all.tex` wird von `1Main.tex` und `Skript.tex` eingebunden und lädt in fester Reihenfolge:

| Datei | Inhalt |
|---|---|
| `setup.tex` | Schalter-Defaults, `\documentclass{scrreprt}`, KOMA-Optionen, Schriften (Bookerly aus `fonts/`), Pakete, biblatex, glossaries, Theorem-Umgebungen |
| `layout.tex` | geometry (abhängig von `\ifisprint`), Listen, Kopf-/Fußzeilen, **alle** `\addtokomafont`, Glossar-Stil, `\verzeichnislogo` |
| `style.tex` | Farbpalette, Fußnoten, minted, Emojis, hyperref/bookmark, PDF-Metadaten |
| `watermark.tex` | ENTWURF-Wasserzeichen, nur bei `\isdrafttrue` |
| danach | `metadata.tex` aus dem Projektroot |

Bilder: `Signet_UniBw.pdf` (Titelseite), `AtheneGespiegelt.png` (Verzeichnisseiten), `Athene.png`.

## Muster

- Neue Pakete in `setup.tex` im passenden Abschnitt ergänzen, nicht in `1Main.tex`.
- Farben nur über die Namen aus `style.tex` (`primary`, `secondary`, `headingcolor`, …) verwenden.
- Druck-/Digital-Unterschiede ausschließlich über `\ifisprint`.

## Gotchas

- `hyperref` wird von minted geladen; Optionen über `\PassOptionsToPackage` vor minted, Rest per `\hypersetup`.
- Keine Pakete laden, die unicode-math doppeln (`amssymb`, `amsfonts`, `amsbsy`).
- `\ifisprint` steuert auch `twoside/openright` – deshalb vor `\documentclass` ausgewertet.
- `setup.aux`/`setup.log` hier sind alte Build-Reste (ignoriert), keine Quelldateien.
