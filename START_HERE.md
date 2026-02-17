# 🎓 START HERE - Schnellstart-Anleitung

Willkommen! Diese Anleitung führt Sie Schritt für Schritt durch die Verwendung dieser LaTeX-Vorlage.

---

## ⚡ Schnellstart (1-2-3)

```bash
# 1. Titelseite anpassen
nano default_frame/Titelseite.tex

# 2. Eigene Kapitel schreiben
nano content/Einleitung.tex

# 3. Kompilieren
./compile.sh
```

**Fertig!** Ihr PDF findet sich in `1Main.pdf` 🎉

---

## 📋 Schritt-für-Schritt Anleitung

### Schritt 1: Titelseite anpassen

Öffnen Sie `default_frame/Titelseite.tex` und suchen Sie nach **"ÄNDERN"**-Kommentaren:

```latex
% Diese Felder müssen Sie anpassen:

\textbf{[Titel Ihrer Arbeit]}              % ÄNDERN: Ihr Titel
Bachelor-Thesis \\                          % ÄNDERN: Bachelor/Master/Dissertation
Studiengang Informatik 2023\\              % ÄNDERN: Ihr Studiengang
Matrikelnummer 1231753\\                   % ÄNDERN: Ihre Matrikelnummer
Prof. Dr.-Ing. Andreas Karcher\\           % ÄNDERN: Ihr Betreuer
```

**Tipp:** Der Autor-Name (Nikolaus Köberlein) kann beibehalten oder geändert werden.

---

### Schritt 2: Kapitel ausfüllen

Die Vorlage enthält Beispiel-Kapitel mit Formatierungshinweisen:

| Datei | Beschreibung | Aktion |
|-------|--------------|--------|
| `content/Einleitung.tex` | Motivation, Zielsetzung, Methodik | Platzhalter ersetzen |
| `content/Grundlagen.tex` | Theoretische Grundlagen, Definitionen | Eigene Grundlagen einfügen |
| `content/Hauptteil.tex` | Implementierung/Konzept | Eigenen Hauptteil schreiben |
| `content/Schluss.tex` | Fazit, Reflexion, Ausblick | Eigenes Fazit verfassen |

**Wie vorgehen?**

1. Öffnen Sie ein Kapitel (z.B. `content/Einleitung.tex`)
2. Lesen Sie die Kommentare (beginnen mit `%`)
3. Ersetzen Sie die Beispieltexte durch Ihre eigenen Inhalte
4. Behalten Sie die Struktur (`\section`, `\subsection`) bei

**Beispiel:**

```latex
% Vorher (Template):
\section{Motivation und Problemstellung}
In diesem Abschnitt beschreiben Sie die \textbf{Motivation} ...

% Nachher (Ihr Text):
\section{Motivation und Problemstellung}
Die Digitalisierung der Verwaltung ist ein zentrales Thema ...
```

---

### Schritt 3: Quellen einfügen

**a) Bibliographie:** Öffnen Sie `bibliography/references.bib`

```bibtex
@book{MeinBuch2024,
  author    = {Müller, Max},
  title     = {Digitale Transformation},
  year      = {2024},
  publisher = {Springer}
}
```

**b) Im Text zitieren:**

```latex
Laut aktuellem Stand der Forschung \cite{MeinBuch2024} ist ...
```

---

### Schritt 4: Glossar anpassen

Öffnen Sie `content/allgemein/Glossar.tex`:

```latex
% Neuen Begriff hinzufügen:
\newglossaryentry{blockchain}{
    name={Blockchain},
    description={Verteilte, unveränderliche Datenbank}
}

% Akronym hinzufügen:
\newacronym{ki}{KI}{Künstliche Intelligenz}
```

**Im Text verwenden:**

```latex
Die \gls{blockchain} ermöglicht ...
Das \gls{ki} System analysiert ...
```

---

### Schritt 5: Kompilieren

**Einfache Kompilierung:**

```bash
./compile.sh
```

**Mit Optionen:**

```bash
# Erst bereinigen, dann kompilieren
./compile.sh --clean

# Schnelle Vorschau (nur 1× LuaLaTeX)
./compile.sh --fast

# Automatisch bei Änderungen neu kompilieren
./compile.sh --watch
```

**Nur bereinigen:**

```bash
./clean-latex.sh
```

---

## 🎨 Erweiterte Anpassungen

### Abstract bearbeiten

Öffnen Sie `content/allgemein/Abstract.tex`:

- **Deutsch** und **Englisch** anpassen
- Beide Versionen werden automatisch eingefügt

### Code-Listings hinzufügen

Siehe Beispiele in `content/Code.tex`:

```latex
\begin{minted}{python}
def hello():
    print("Hallo Welt")
\end{minted}
```

Unterstützte Sprachen: Python, Java, Scala, JavaScript, JSON, Bash, C, C++, SQL, XML, und 300+ mehr!

### Tabellen erstellen

```latex
\begin{table}[htbp]
\centering
\caption{Anforderungsübersicht}
\label{tab:requirements}
\begin{tabular}{lll}
\toprule
ID & Anforderung & Priorität \\
\midrule
R1 & Benutzerauthentifizierung & Hoch \\
R2 & Datenverschlüsselung & Hoch \\
\bottomrule
\end{tabular}
\end{table}
```

### Abbildungen einfügen

```latex
\begin{figure}[htbp]
\centering
\includegraphics[width=0.8\textwidth]{media/diagramm.png}
\caption{Systemarchitektur}
\label{fig:architecture}
\end{figure}
```

Bilder im `media/` Verzeichnis ablegen!

---

## ❓ Häufige Fragen

### Kompilierung schlägt fehl?

**Problem:** Fehler bei der Kompilierung

**Lösung:**
1. Prüfen Sie die Fehlermeldung
2. Suchen Sie in der `.log` Datei
3. Häufigste Ursachen:
   - Fehlende Pakete → Installieren Sie TeX Live 2025
   - Syntaxfehler in `.tex` Dateien → Prüfen Sie `{}` Klammern
   - Ungültige Zeichen → UTF-8 Encoding verwenden

### Inhaltsverzeichnis ist leer?

**Lösung:** Mehrmals kompilieren!

```bash
./compile.sh  # Macht automatisch 4× LuaLaTeX
```

### Glossar-Einträge erscheinen nicht?

**Lösung:** Einträge müssen im Text verwendet werden!

```latex
% In Glossar.tex definieren:
\newglossaryentry{test}{...}

% Im Text verwenden:
\gls{test}  % ← Wichtig!
```

### Literaturverzeichnis ist leer?

**Lösung:** Quellen müssen zitiert werden!

```latex
% In references.bib definieren:
@book{key2024, ...}

% Im Text zitieren:
\cite{key2024}  % ← Wichtig!
```

---

## 🆘 Hilfe & Support

### Dokumentation

- **README.md** - Umfassende Anleitung
- **readme.tex** - Projektstruktur-Dokumentation (kompiliert zu readme.pdf)

### Bei Problemen

1. **Log-Datei prüfen:** `1Main.log`
2. **Fehlermeldung googeln:** Meist gibt es schnelle Lösungen
3. **LaTeX-Forum:** https://tex.stackexchange.com/

### Wichtige Befehle

```bash
# Kompilieren
./compile.sh

# Schnelle Vorschau
./compile.sh --fast

# Bereinigen
./clean-latex.sh

# Mit Bereinigung kompilieren
./compile.sh --clean

# Auto-Watch Modus
./compile.sh --watch
```

---

## ✅ Checkliste vor Abgabe

- [ ] Titelseite vollständig ausgefüllt
- [ ] Alle "TODO" und Platzhalter entfernt
- [ ] Rechtschreibung geprüft
- [ ] Alle Abbildungen haben Unterschriften
- [ ] Alle Tabellen haben Überschriften
- [ ] Literaturverzeichnis vollständig
- [ ] Glossar und Abkürzungen definiert
- [ ] PDF kompiliert ohne Fehler
- [ ] Seitenzahlen korrekt
- [ ] Inhaltsverzeichnis aktuell
- [ ] Eidesstattliche Erklärung unterschrieben

---

## 🎯 Nächste Schritte

1. ✅ Titelseite anpassen
2. ✅ Einleitung schreiben
3. ✅ Grundlagen erarbeiten
4. ✅ Hauptteil verfassen
5. ✅ Fazit schreiben
6. ✅ Kompilieren und PDF prüfen
7. ✅ Abgeben! 🎓

---

**Viel Erfolg mit Ihrer Arbeit!** 🚀

*Bei Fragen zur Vorlage: Siehe README.md für detaillierte Informationen.*
