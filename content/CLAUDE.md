# content/

Inhalte der Arbeit. Die Beispielkapitel zeigen typische Elemente (Abbildungen, Tabellen, Code, Theoreme, Zitate)
und werden von Nutzer:innen überschrieben.

| Datei | Zweck |
|---|---|
| `Einleitung.tex`, `Grundlagen.tex`, `Hauptteil.tex`, `Schluss.tex` | Beispielkapitel (`\chapter{…}` + `\label{chap:…}`) |
| `Code.tex` | Anhang mit minted-Beispielen |
| `allgemein/Abstract.tex` | Abstract (unnummeriert, im Inhaltsverzeichnis) |
| `allgemein/Aufgabenstellung.tex` | Formale Aufgabenstellung (nur Bachelor/Master) |
| `allgemein/Danksagung.tex` | Vorwort/Danksagung (optional) |
| `allgemein/Glossar.tex` | Glossar- und Abkürzungseinträge (`\newglossaryentry`, `\newacronym`), in der Präambel geladen |

## Muster

- Neues Kapitel: Datei hier anlegen, in `1Main.tex` per `\input{content/Name}` einbinden.
- Erste Zeile `% !TEX root = ../1Main.tex` (bzw. `../../1Main.tex` in `allgemein/`) für Editor-Builds.
- Labels mit Präfix: `chap:`, `sec:`, `fig:`, `tab:`, `lst:`.
- Zitieren mit `\cite{key}` / `\textcite{key}`; Abkürzungen mit `\gls{key}`.
- Bilder liegen in `media/` (`\graphicspath`), also `\includegraphics{name}` ohne Pfad.

## Gotchas

- `allgemein/Glossar.tex` wird vor `\begin{document}` geladen – dort keinen Text ausgeben.
- Code-Blöcke brauchen `--shell-escape` (minted).
