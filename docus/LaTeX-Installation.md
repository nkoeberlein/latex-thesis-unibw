# LaTeX-Installation – Anleitung für VS Code & Antigravity

> **Ziel dieser Anleitung:** LaTeX auf Ihrem Rechner installieren, VS Code als Editor einrichten und die KI-Unterstützung durch **Antigravity** nutzen, um effizient wissenschaftliche Arbeiten mit der UniBw-Vorlage zu schreiben.

---

## Inhaltsverzeichnis

1. [Überblick](#1-überblick)
2. [Schritt 1 – LaTeX installieren (TeX Live)](#2-schritt-1--latex-installieren-tex-live)
   - [Windows](#21-windows)
   - [macOS](#22-macos)
   - [Linux (Ubuntu/Debian)](#23-linux-ubuntudebian)
3. [Schritt 2 – Python & Pygments installieren](#3-schritt-2--python--pygments-installieren)
4. [Schritt 3 – VS Code einrichten](#4-schritt-3--vs-code-einrichten)
5. [Schritt 4 – Vorlage öffnen & kompilieren](#5-schritt-4--vorlage-öffnen--kompilieren)
6. [Schritt 5 – Antigravity nutzen](#6-schritt-5--antigravity-nutzen)
7. [Häufige Fehler & Lösungen](#7-häufige-fehler--lösungen)

---

## 1. Überblick

Diese Vorlage verwendet **LuaLaTeX** (Teil von TeX Live) als Compiler. Sie benötigen:

| Komponente | Zweck | Pflicht |
|---|---|---|
| **TeX Live 2025+** | LaTeX-Compiler (LuaLaTeX, Biber, makeglossaries) | ✅ Ja |
| **Python 3** | Wird von `minted` für Code-Highlighting benötigt | ✅ Ja |
| **Pygments** | Syntax-Highlighting-Bibliothek für `minted` | ✅ Ja |
| **VS Code** | Empfohlener Editor mit LaTeX-Integration | ⭐ Empfohlen |
| **LaTeX Workshop** | VS Code-Extension für PDF-Vorschau & Kompilierung | ⭐ Empfohlen |
| **Antigravity** | KI-Assistent direkt in VS Code | ⭐ Empfohlen |

---

## 2. Schritt 1 – LaTeX installieren (TeX Live)

### 2.1 Windows

1. Laden Sie den **TeX Live Installer** herunter:  
   👉 https://www.tug.org/texlive/acquire-netinstall.html

2. Führen Sie `install-tl-windows.exe` als Administrator aus.

3. Wählen Sie im Installer:
   - **Schema:** `full` (empfohlen, ca. 7 GB) **oder** `medium` (ca. 3 GB, ausreichend für diese Vorlage)
   - Installationspfad: Standard beibehalten (z. B. `C:\texlive\2025`)

4. Warten Sie die Installation ab (kann 30–60 Minuten dauern).

5. **Überprüfung** – Öffnen Sie eine neue Eingabeaufforderung (CMD) und tippen Sie:
   ```
   lualatex --version
   biber --version
   ```
   Beide Befehle sollten eine Versionsnummer ausgeben.

> **Alternative für Windows:** [MiKTeX](https://miktex.org/) ist leichter und installiert Pakete bei Bedarf automatisch. Für diese Vorlage ist TeX Live jedoch zuverlässiger.

---

### 2.2 macOS

1. Laden Sie **MacTeX** herunter (enthält vollständiges TeX Live):  
   👉 https://www.tug.org/mactex/

2. Öffnen Sie die `.pkg`-Datei und folgen Sie dem Installer.

3. **Überprüfung** – Öffnen Sie das Terminal:
   ```bash
   lualatex --version
   biber --version
   ```

---

### 2.3 Linux (Ubuntu/Debian)

**Option A – Paketmanager (einfach, aber ältere Version):**

```bash
sudo apt-get update
sudo apt-get install texlive-full
```

> ⚠️ `texlive-full` installiert alle Pakete (~5 GB). Alternativ reicht `texlive-luatex texlive-lang-german texlive-bibtex-extra biber` für diese Vorlage.

**Option B – Aktuelles TeX Live direkt von tug.org (empfohlen):**

```bash
# Installer herunterladen
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
cd install-tl-*/

# Installer starten (interaktiv)
sudo ./install-tl

# Im Menü: 'I' drücken zum Installieren (Full-Schema)
```

Nach der Installation den PATH setzen (in `~/.bashrc` oder `~/.zshrc` eintragen):

```bash
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
```

**Überprüfung:**

```bash
lualatex --version
biber --version
makeglossaries --version
```

---

## 3. Schritt 2 – Python & Pygments installieren

Das `minted`-Paket (für Code-Highlighting) benötigt Python und Pygments.

### Windows

```powershell
# Python von https://www.python.org/downloads/ installieren
# Dann in der Eingabeaufforderung:
pip install Pygments
```

### macOS / Linux

```bash
# Python ist meist vorinstalliert, prüfen mit:
python3 --version

# Pygments installieren:
pip3 install Pygments

# Überprüfung:
pygmentize --version
```

---

## 4. Schritt 3 – VS Code einrichten

### 4.1 VS Code installieren

Laden Sie VS Code herunter und installieren Sie es:  
👉 https://code.visualstudio.com/

### 4.2 LaTeX Workshop Extension installieren

1. Öffnen Sie VS Code
2. Drücken Sie `Strg+Shift+X` (Extensions-Panel öffnen)
3. Suchen Sie nach **„LaTeX Workshop"** (von James Yu)
4. Klicken Sie auf **Installieren**

### 4.3 LaTeX Workshop konfigurieren

Öffnen Sie die VS Code Einstellungen (`Strg+,`) → klicken Sie oben rechts auf das **JSON-Symbol** (Datei öffnen) und fügen Sie folgende Konfiguration ein:

```json
{
  "latex-workshop.latex.tools": [
    {
      "name": "lualatex",
      "command": "lualatex",
      "args": [
        "--shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ]
    },
    {
      "name": "biber",
      "command": "biber",
      "args": ["%DOCFILE%"]
    },
    {
      "name": "makeglossaries",
      "command": "makeglossaries",
      "args": ["%DOCFILE%"]
    }
  ],
  "latex-workshop.latex.recipes": [
    {
      "name": "LuaLaTeX + Biber + Glossar (vollständig)",
      "tools": [
        "lualatex",
        "makeglossaries",
        "biber",
        "lualatex",
        "lualatex"
      ]
    },
    {
      "name": "LuaLaTeX (schnell)",
      "tools": ["lualatex"]
    }
  ],
  "latex-workshop.latex.recipe.default": "LuaLaTeX + Biber + Glossar (vollständig)",
  "latex-workshop.view.pdf.viewer": "tab",
  "latex-workshop.latex.autoBuild.run": "onSave"
}
```

> **Hinweis:** Mit `"autoBuild.run": "onSave"` kompiliert VS Code automatisch beim Speichern einer `.tex`-Datei.

### 4.4 Nützliche VS Code Shortcuts

| Aktion | Shortcut |
|---|---|
| PDF-Vorschau öffnen | `Strg+Alt+V` |
| Kompilieren | `Strg+Alt+B` |
| SyncTeX (Cursor → PDF) | `Strg+Alt+J` |
| Fehler anzeigen | `Strg+Shift+M` |

---

## 5. Schritt 4 – Vorlage öffnen & kompilieren

### 5.1 Projektordner öffnen

```
Datei → Ordner öffnen → wissenschaftlArbeit/
```

Oder im Terminal:

```bash
code /pfad/zu/wissenschaftlArbeit
```

### 5.2 Hauptdatei öffnen

Öffnen Sie `1Main.tex` im Explorer-Panel von VS Code. Dies ist das Hauptdokument.

### 5.3 Kompilieren

**Option A – Via VS Code (empfohlen):**
- Speichern Sie `1Main.tex` → Kompilierung startet automatisch
- Oder: `Strg+Alt+B` → Rezept auswählen

**Option B – Via Terminal in VS Code (`Strg+ö`):**

```bash
# Vollständige Kompilierung
./compile.sh

# Schnelle Vorschau (nur 1× LuaLaTeX)
./compile.sh --fast

# Mit Bereinigung
./compile.sh --clean

# Auto-Watch: Neu kompilieren bei Änderungen
./compile.sh --watch
```

Das fertige PDF erscheint als `1Main.pdf` im Projektordner und wird in VS Code automatisch in der PDF-Vorschau aktualisiert.

---

## 6. Schritt 5 – Antigravity nutzen

**Antigravity** ist ein KI-Assistent, der direkt in VS Code integriert ist und Ihnen beim Schreiben Ihrer wissenschaftlichen Arbeit hilft.

### 6.1 Was kann Antigravity?

- **LaTeX-Code schreiben:** Tabellen, Abbildungen, Formeln, Listings auf Befehl erstellen
- **Fehler erklären:** Fehlermeldungen aus dem Log analysieren und Lösungen vorschlagen
- **Text verbessern:** Wissenschaftlichen Stil prüfen und verbessern
- **Vorlage anpassen:** Konfigurationsdateien erklären und anpassen
- **Quellen verwalten:** BibTeX-Einträge formatieren und einfügen

### 6.2 Typische Anwendungsfälle

**Tabelle erstellen lassen:**
> „Erstelle eine LaTeX-Tabelle mit booktabs für folgende Daten: ..."

**Fehler beheben:**
> „Ich bekomme diesen Fehler: `! LaTeX Error: File 'minted.sty' not found.` Was muss ich tun?"

**Abschnitt schreiben:**
> „Schreibe einen wissenschaftlichen Einleitungsabsatz für das Thema X-Road und das Once-Only-Prinzip."

**BibTeX-Eintrag:**
> „Erstelle einen BibTeX-Eintrag für diesen Artikel: [Titel, Autor, Jahr, DOI]"

**Formel einfügen:**
> „Wie schreibe ich die Formel für die Fourier-Transformation in LaTeX?"

### 6.3 Tipps für effektive Nutzung

1. **Kontext geben:** Öffnen Sie die relevante `.tex`-Datei, bevor Sie Antigravity fragen – es sieht, welche Datei Sie gerade bearbeiten.

2. **Fehlermeldungen einfügen:** Kopieren Sie die komplette Fehlermeldung aus dem Terminal oder dem LaTeX Workshop Output-Panel.

3. **Iterativ arbeiten:** Lassen Sie sich Entwürfe erstellen, prüfen Sie diese und bitten Sie um Anpassungen.

4. **Vorlage erklären lassen:** Fragen Sie, was bestimmte Befehle in den Style-Dateien bewirken.

### 6.4 Beispiel-Workflow mit Antigravity

```
1. Sie öffnen content/Grundlagen.tex in VS Code
2. Sie fragen Antigravity: "Schreibe einen Abschnitt über REST-APIs 
   mit einer Vergleichstabelle zu SOAP"
3. Antigravity erstellt den LaTeX-Code direkt in der Datei
4. Sie speichern → VS Code kompiliert automatisch
5. Sie prüfen das PDF in der Vorschau
6. Bei Bedarf: "Passe die Tabelle an, füge eine Spalte für GraphQL hinzu"
```

---

## 7. Häufige Fehler & Lösungen

### ❌ `lualatex: command not found`

**Ursache:** TeX Live ist nicht im PATH.

**Lösung (Linux/macOS):**
```bash
# PATH prüfen:
echo $PATH

# TeX Live Pfad hinzufügen (in ~/.bashrc oder ~/.zshrc):
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
source ~/.bashrc
```

**Lösung (Windows):** Systemsteuerung → Umgebungsvariablen → PATH → TeX Live `bin`-Ordner hinzufügen (z. B. `C:\texlive\2025\bin\windows`).

---

### ❌ `You must invoke LaTeX with the -shell-escape flag`

**Ursache:** `minted` benötigt `--shell-escape`.

**Lösung:** Die VS Code Konfiguration aus Schritt 4.3 enthält `--shell-escape` bereits. Beim manuellen Kompilieren:
```bash
lualatex --shell-escape 1Main.tex
```

---

### ❌ `Package minted Error: Missing Pygments`

**Ursache:** Pygments ist nicht installiert oder nicht im PATH.

**Lösung:**
```bash
pip3 install Pygments
# Überprüfung:
pygmentize --version
```

---

### ❌ Inhaltsverzeichnis / Glossar / Literaturverzeichnis ist leer

**Ursache:** LaTeX benötigt mehrere Kompilierungsdurchläufe.

**Lösung:** Verwenden Sie das vollständige Kompilierungsrezept:
```bash
./compile.sh  # Führt automatisch 4× LuaLaTeX + Biber + makeglossaries aus
```

---

### ❌ `Font not found` oder Schriftart-Warnungen

**Ursache:** Systemschriften nicht gefunden (besonders unter Windows).

**Lösung:**
```bash
# Schriftarten-Cache aktualisieren (Linux/macOS):
fc-cache -fv

# Unter Windows: TeX Live aktualisieren
tlmgr update --all
```

---

### ❌ Kompilierung bricht ab (roter Kreis in VS Code)

**Lösung:**
1. Klicken Sie in VS Code auf **„View → Output"** → wählen Sie **„LaTeX Workshop"**
2. Scrollen Sie zum ersten `!`-Fehler
3. Oder öffnen Sie `1Main.log` und suchen Sie nach `! `

Häufigste Ursachen:
- Fehlende `}` oder `{` Klammern
- Ungültige Sonderzeichen (z. B. `&` ohne `\&` außerhalb von Tabellen)
- Fehlende Pakete → `tlmgr install <paketname>`

---

## ✅ Installations-Checkliste

- [ ] TeX Live 2023+ installiert (`lualatex --version` funktioniert)
- [ ] Biber installiert (`biber --version` funktioniert)
- [ ] makeglossaries installiert (`makeglossaries --version` funktioniert)
- [ ] Python 3 installiert (`python3 --version` funktioniert)
- [ ] Pygments installiert (`pygmentize --version` funktioniert)
- [ ] VS Code installiert
- [ ] LaTeX Workshop Extension installiert
- [ ] VS Code Konfiguration (settings.json) angepasst
- [ ] Vorlage kompiliert → `1Main.pdf` wurde erstellt
- [ ] PDF-Vorschau in VS Code funktioniert

---

*Bei weiteren Fragen steht Ihnen Antigravity direkt in VS Code zur Verfügung – einfach fragen!*
