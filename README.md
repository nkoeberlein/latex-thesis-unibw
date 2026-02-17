# LaTeX-Vorlage für wissenschaftliche Arbeiten - UniBw München

![LaTeX](https://img.shields.io/badge/LaTeX-LuaLaTeX-008080?logo=latex)
![TeX Live](https://img.shields.io/badge/TeX%20Live-2025-blue)
![License](https://img.shields.io/badge/License-Academic-green)
![Status](https://img.shields.io/badge/Status-Production%20Ready-success)
![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen)

Moderne LaTeX-Vorlage für Bachelor-, Master- und Doktorarbeiten an der Universität der Bundeswehr München, optimiert für **LuaLaTeX** (Stand: 2026).

> **🚀 Neu hier?** → Siehe [START_HERE.md](START_HERE.md) für eine Schritt-für-Schritt-Anleitung!

## ✨ Features

- **Modernes LaTeX**: Vollständig auf LuaLaTeX optimiert (keine veralteten Pakete)
- **Code-Highlighting**: Minted-Integration für 300+ Programmiersprachen
- **Unicode-Support**: Native Unterstützung für UTF-8, Emojis und Sonderzeichen
- **Professionelles Layout**: UniBw München Corporate Design
- **Automatisierte Verzeichnisse**: Inhalt, Abbildungen, Tabellen, Abkürzungen, Glossar
- **Moderne Tabellen**: tabularray statt veralteter Pakete
- **Flexible Bibliographie**: BibLaTeX mit Biber-Backend

## 📋 Voraussetzungen

### Erforderliche Software

1. **LuaLaTeX** (TeX Live 2023 oder neuer empfohlen)
  - Windows: [MiKTeX](https://miktex.org/) oder [TeX Live](https://www.tug.org/texlive/)
  - macOS: [MacTeX](https://www.tug.org/mactex/)
  - Linux: `sudo apt-get install texlive-full` (Ubuntu/Debian)

2. **Python 3** (für minted Code-Highlighting)
   ```bash
   sudo apt-get install python3 python3-pip
   ```

3. **Pygments** (Syntax-Highlighting-Bibliothek)
   ```bash
   pip3 install Pygments
   ```

4. **Biber** (Bibliographie-Tool, meist in TeX-Distribution enthalten)

### Optional

- **Visual Studio Code** mit [LaTeX Workshop Extension](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
- **TeXstudio** oder **Overleaf** (mit LuaLaTeX-Einstellung)

## 🚀 Schnellstart

### 1. Vorlage anpassen

1. **Titelseite**: Öffnen Sie `default_frame/Titelseite.tex`
   - Ersetzen Sie `[Titel Ihrer Arbeit]` mit Ihrem Titel
   - Passen Sie Studiengang, Matrikelnummer und Betreuer an

2. **Hauptdokument**: Öffnen Sie `1Main.tex`
   - Aktivieren/deaktivieren Sie gewünschte Verzeichnisse
   - Fügen Sie Ihre Kapitel hinzu

3. **Kapitel schreiben**:
   - Bearbeiten Sie die Dateien in `content/`
   - Nutzen Sie die Beispiele als Vorlage

### 2. Kompilierung

#### Manuell (Terminal/Kommandozeile)

```bash
# Vollständige Kompilierung mit allen Verzeichnissen
lualatex --shell-escape 1Main.tex
makeglossaries 1Main
biber 1Main
lualatex --shell-escape 1Main.tex
lualatex --shell-escape 1Main.tex
```

#### Mit Shell-Script (empfohlen)

```bash
# Normale Kompilierung (alle Verzeichnisse)
./compile.sh

# Schnelle Kompilierung (nur 1× LuaLaTeX für Vorschau)
./compile.sh --fast

# Mit Bereinigung zuerst
./compile.sh --clean

# Automatische Neu-Kompilierung bei Änderungen
./compile.sh --watch
```

#### Nur bereinigen

```bash
./clean-latex.sh
```

## 📁 Projektstruktur

```
wissenschaftlArbeit/
├── 1Main.tex                    # Hauptdokument
├── README.md                    # Diese Datei
├── compile.sh                   # Kompilierungsskript
├── clean-latex.sh              # Aufräumskript
│
├── content/                    # Ihre Kapitel
│   ├── Einleitung.tex
│   ├── Grundlagen.tex
│   ├── Hauptteil.tex
│   ├── Schluss.tex
│   ├── Code.tex               # Anhang: Code-Beispiele
│   └── allgemein/
│       ├── Abstract.tex
│       └── Glossar.tex        # Glossar-Definitionen
│
├── default_frame/             # Verzeichnisse und formale Seiten
│   ├── Titelseite.tex
│   ├── Inhaltsverzeichnis.tex
│   ├── Literaturverzeichnis.tex
│   ├── Glossar.tex
│   └── SelbststaendigkeitserklaerungUniBwM.tex
│
├── default_style/             # Styling und Pakete
│   ├── load_all.tex          # Lädt alle Konfigurationen
│   ├── load_packages.tex     # Paket-Definitionen
│   ├── Schriftart-settings.tex
│   ├── Farben_definieren-settings.tex
│   └── ...
│
├── bibliography/
│   └── references.bib        # Ihre Literaturquellen
│
├── media/                    # Bilder und Grafiken
└── fonts/                    # Schriftarten (falls benötigt)
```

## 📝 Verwendung

### Kapitel hinzufügen

1. Erstellen Sie eine neue `.tex`-Datei in `content/`
2. Fügen Sie in `1Main.tex` hinzu:
   ```latex
   \input{content/NeuesKapitel}
   \newpage
   ```

### Literatur zitieren

1. Fügen Sie Einträge in `bibliography/references.bib` hinzu:
   ```bibtex
   @article{autor2024titel,
       author = {Autor, Max},
       title = {Titel des Artikels},
       journal = {Zeitschrift},
       year = {2024}
   }
   ```

2. Zitieren Sie im Text:
   ```latex
   Wie in \cite{autor2024titel} beschrieben, \dots
   ```

### Glossar/Abkürzungen verwenden

1. Definieren Sie Begriffe in `content/allgemein/Glossar.tex`:
   ```latex
   \newacronym{api}{API}{Application Programming Interface}
   ```

2. Verwenden Sie im Text:
   ```latex
   \gls{api}  % Beim ersten Mal: Application Programming Interface (API)
              % Später: API
   ```

### Code-Listings

Mit minted (empfohlen):
```latex
\begin{listing}[htbp]
\begin{minted}[linenos,frame=lines]{python}
def hello_world():
    print("Hello, World!")
\end{minted}
\caption{Python Hello World}
\label{lst:hello}
\end{listing}
```

### Tabellen

Mit booktabs (modern):
```latex
\begin{table}[htbp]
    \centering
    \caption{Beispieltabelle}
    \label{tab:beispiel}
    \begin{tabular}{lcc}
        \toprule
        \textbf{Spalte 1} & \textbf{Spalte 2} & \textbf{Spalte 3} \\
        \midrule
        Wert 1 & Wert 2 & Wert 3 \\
        \bottomrule
    \end{tabular}
\end{table}
```

## 🎨 Anpassungen

### Farben ändern

Bearbeiten Sie `default_style/Farben_definieren-settings.tex`:
```latex
\definecolor{primary}{RGB}{0,82,147}     % UniBw Blau
\definecolor{secondary}{RGB}{227,6,19}   % UniBw Rot
```

### Schriftart ändern

Bearbeiten Sie `default_style/Schriftart-settings.tex`:
```latex
\setmainfont{TeX Gyre Termes}  % Times-ähnlich
% Alternative:
% \setmainfont{Latin Modern Roman}
```

## 🔧 Problembehandlung

### "minted Error: You must invoke LaTeX with the -shell-escape flag"

**Lösung**: Verwenden Sie `--shell-escape` beim Kompilieren:
```bash
lualatex --shell-escape 1Main.tex
```

In TeXstudio: Optionen → TeXstudio konfigurieren → Befehle → LuaLaTeX:
```
lualatex -synctex=1 -interaction=nonstopmode --shell-escape %.tex
```

### "Package minted Error: Missing Pygments"

**Lösung**: Installieren Sie Pygments:
```bash
pip3 install Pygments
```

### "I can't find file 'XYZ.tex'"

**Lösung**: Prüfen Sie die Pfade in `1Main.tex` - alle Pfade müssen relativ zum Hauptdokument sein.

### Glossar wird nicht angezeigt

**Lösung**: Führen Sie `makeglossaries` aus:
```bash
makeglossaries 1Main
```

### Bibliographie ist leer

**Lösung**:
1. Prüfen Sie, ob Sie `\cite{...}` im Text verwendet haben
2. Führen Sie `biber 1Main` aus
3. Kompilieren Sie erneut mit LuaLaTeX

## 📚 Dokumentation

- Ausführliche Vorlage-Dokumentation: Kompilieren Sie `readme.tex`
- LaTeX-Einführung: [Overleaf Documentation](https://www.overleaf.com/learn)
- BibLaTeX: [BibLaTeX Documentation](https://ctan.org/pkg/biblatex)
- Minted: [Minted Manual](https://ctan.org/pkg/minted)

## 🤝 Beitragen

Diese Vorlage wurde für Studierende der UniBw München erstellt. Verbesserungsvorschläge sind willkommen!

## ❓ FAQ - Häufig gestellte Fragen

### Allgemeine Fragen

**Q: Kann ich diese Vorlage für meine Arbeit verwenden?**  
A: Ja! Die Vorlage ist für alle wissenschaftlichen Arbeiten an der UniBw München gedacht.

**Q: Muss ich LuaLaTeX verwenden oder geht auch pdfLaTeX?**  
A: Diese Vorlage ist speziell für LuaLaTeX optimiert. Mit pdfLaTeX würde sie nicht funktionieren (moderne Pakete, Unicode-Support).

**Q: Wo finde ich eine Schnellstart-Anleitung?**  
A: Siehe [START_HERE.md](START_HERE.md) für eine ausführliche Schritt-für-Schritt-Anleitung.

### Kompilierung

**Q: Wie oft muss ich kompilieren?**  
A: Für korrekte Referenzen mindestens 3-4 Mal. Das Script `./compile.sh` macht das automatisch.

**Q: Die Kompilierung dauert sehr lange, gibt es eine schnellere Alternative?**  
A: Ja! Verwenden Sie `./compile.sh --fast` für schnelle Vorschauen (nur 1× LuaLaTeX).

**Q: Was macht `--watch` Modus?**  
A: Der Watch-Modus kompiliert automatisch neu, wenn Sie .tex oder .bib Dateien ändern. Praktisch beim Schreiben!

### Inhalte

**Q: Das Inhaltsverzeichnis ist leer!**  
A: Kompilieren Sie mehrmals (mindestens 2×). Das ist normal bei LaTeX - erst beim zweiten Durchlauf werden die Referenzen aufgelöst.

**Q: Meine Glossar-Einträge erscheinen nicht!**  
A: Glossar-Einträge müssen im Text verwendet werden (`\gls{begriff}`), damit sie im Glossar erscheinen.

**Q: Das Literaturverzeichnis bleibt leer!**  
A: Sie müssen Quellen im Text zitieren (`\cite{key}`). Nur definierte Quellen, die auch zitiert wurden, erscheinen.

**Q: Kann ich die Beispiel-Kapitel löschen?**  
A: Besser nicht! Nutzen Sie sie als Vorlage und ersetzen Sie den Inhalt. Die Struktur ist bewährt.

### Anpassungen

**Q: Wie ändere ich die Schriftart?**  
A: Bearbeiten Sie `default_style/Schriftart-settings.tex`. Dort können Sie andere Fonts mit `\setmainfont{...}` setzen.

**Q: Kann ich die UniBw-Farben ändern?**  
A: Technisch ja, aber für offizielle Arbeiten sollten die Corporate Design Farben beibehalten werden.

**Q: Wie füge ich ein neues Kapitel hinzu?**  
A: Erstellen Sie eine .tex-Datei in `content/` und fügen Sie in `1Main.tex` ein: `\input{content/NeuesKapitel}`

### Fehler und Probleme

**Q: "Missing Pygments" Fehler**  
A: Installieren Sie Pygments: `pip3 install Pygments`

**Q: "shell-escape" Fehler**  
A: Verwenden Sie das Flag `--shell-escape` beim Kompilieren. Die Scripts machen das automatisch.

**Q: "Font not found" Warnung**  
A: Die Standardfonts (Latin Modern, TeX Gyre) sollten mit TeX Live installiert sein. Prüfen Sie Ihre TeX-Installation.

**Q: Kompilierung bricht ab**  
A: 
1. Prüfen Sie die `.log` Datei für Details
2. Häufigste Ursachen: Syntaxfehler (z.B. fehlende `}` Klammer), fehlende Pakete, ungültige Zeichen
3. Zeile-für-Zeile Kommentieren (`%`) hilft beim Eingrenzen

### Best Practices

**Q: Soll ich Bilder als PNG oder PDF einbinden?**  
A: PDF für Vektorgrafiken (scharf bei jeder Größe), PNG für Screenshots/Fotos.

**Q: Wie organisiere ich große Arbeiten am besten?**  
A: Ein Kapitel = Eine Datei. Nutzen Sie aussagekräftige Dateinamen und Labels (`\label{chap:einleitung}`).

**Q: Sollte ich die Build-Dateien (.aux, .log) in Git committen?**  
A: Nein! Die `.gitignore` enthält bereits alle temporären Dateien. Nur die .tex, .bib und Medien-Dateien committen.

**Q: Wie kann ich die Vorlage weitergeben?**  
A: Löschen Sie erst Ihre Inhalte und Build-Artefakte (`./clean-latex.sh`), dann können Sie den gesamten Ordner teilen.

---

## 📄 Lizenz

Diese Vorlage ist frei verwendbar für akademische Zwecke an der Universität der Bundeswehr München.

## 📞 Kontakt

Bei Fragen zur Vorlage wenden Sie sich an:
- **Fakultät Informatik**, Universität der Bundeswehr München
- **Institut für Angewandte Informatik**

---

**Viel Erfolg bei Ihrer Arbeit!** 🎓
