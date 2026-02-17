#!/bin/bash
# ===================================================================
# LaTeX Kompilierungsskript für LuaLaTeX-Projekte
# Für wissenschaftliche Arbeiten mit Glossar und Bibliographie
# ===================================================================

# Farben für Ausgabe
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Hauptdokument (ohne .tex)
MAIN="1Main"

# === Kommandozeilen-Optionen ===
CLEAN_FIRST=false
FAST_MODE=false
WATCH_MODE=false

# Hilfsfunktion
usage() {
    echo "Verwendung: $0 [OPTIONEN]"
    echo ""
    echo "Optionen:"
    echo "  --clean    Erst bereinigen, dann kompilieren"
    echo "  --fast     Schnelle Kompilierung (nur 1× LuaLaTeX, keine Referenzen)"
    echo "  --watch    Automatisch bei Änderungen neu kompilieren (erfordert inotify-tools)"
    echo "  --help     Diese Hilfe anzeigen"
    echo ""
    echo "Beispiele:"
    echo "  $0                  # Normale Kompilierung"
    echo "  $0 --clean          # Erst bereinigen, dann kompilieren"
    echo "  $0 --fast           # Schnelle Kompilierung für Vorschau"
    echo "  $0 --watch          # Automatische Neu-Kompilierung bei Änderungen"
    exit 0
}

# Kommandozeilen-Argumente parsen
while [[ $# -gt 0 ]]; do
    case $1 in
        --clean)
            CLEAN_FIRST=true
            shift
            ;;
        --fast)
            FAST_MODE=true
            shift
            ;;
        --watch)
            WATCH_MODE=true
            shift
            ;;
        --help)
            usage
            ;;
        *)
            echo -e "${RED}Unbekannte Option: $1${NC}"
            usage
            ;;
    esac
done

# === Watch-Modus ===
if [ "$WATCH_MODE" = true ]; then
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}Watch-Modus aktiviert${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    # Prüfe ob inotifywait verfügbar ist
    if ! command -v inotifywait &> /dev/null; then
        echo -e "${RED}Fehler: inotify-tools nicht installiert!${NC}"
        echo "Installiere mit: sudo apt-get install inotify-tools"
        exit 1
    fi
    
    echo "Überwache Änderungen in .tex und .bib Dateien..."
    echo "Drücke Ctrl+C zum Beenden"
    echo ""
    
    # Erste Kompilierung
    $0 --fast
    
    # Überwache Änderungen
    while true; do
        inotifywait -r -e modify --include '.*\.(tex|bib)$' . 2>/dev/null
        echo -e "${YELLOW}Änderung erkannt, neu kompilieren...${NC}"
        sleep 1  # Kurze Pause
        $0 --fast
    done
    exit 0
fi

# === Bereinigung ===
if [ "$CLEAN_FIRST" = true ]; then
    echo -e "${YELLOW}Bereinige Build-Dateien...${NC}"
    ./clean-latex.sh
    echo ""
fi

# === Kompilierung ===
echo -e "${GREEN}========================================${NC}"
if [ "$FAST_MODE" = true ]; then
    echo -e "${GREEN}Schnelle LaTeX Kompilierung...${NC}"
else
    echo -e "${GREEN}Vollständige LaTeX Kompilierung...${NC}"
fi
echo -e "${GREEN}========================================${NC}"
echo ""

if [ "$FAST_MODE" = true ]; then
    # === SCHNELLER MODUS: Nur 1× LuaLaTeX ===
    echo -e "${YELLOW}[1/1] LuaLaTeX-Kompilierung...${NC}"
    lualatex --shell-escape -interaction=nonstopmode "$MAIN.tex" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Fehler bei LuaLaTeX-Kompilierung!${NC}"
        echo "Führe mit vollständiger Ausgabe aus:"
        lualatex --shell-escape -interaction=nonstopmode "$MAIN.tex"
        exit 1
    fi
    echo -e "${GREEN}✓ Kompilierung abgeschlossen${NC}"
else
    # === VOLLSTÄNDIGER MODUS ===
    
    # Schritt 1: Erste LuaLaTeX-Kompilierung
    echo -e "${YELLOW}[1/7] Erste LuaLaTeX-Kompilierung...${NC}"
    lualatex --shell-escape -interaction=nonstopmode "$MAIN.tex" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Fehler bei erster LuaLaTeX-Kompilierung!${NC}"
        echo "Zeige letzte Fehlerausgabe:"
        tail -n 30 "$MAIN.log"
        exit 1
    fi
    echo -e "${GREEN}✓ Erste Kompilierung abgeschlossen${NC}"
    echo ""
    
    # Schritt 2: Glossar erstellen
    echo -e "${YELLOW}[2/7] Glossar erstellen (makeglossaries)...${NC}"
    makeglossaries "$MAIN" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${YELLOW}⚠ Warnung beim Glossar (wird oft ignoriert)${NC}"
    else
        echo -e "${GREEN}✓ Glossar erstellt${NC}"
    fi
    echo ""
    
    # Schritt 3: Bibliographie erstellen
    echo -e "${YELLOW}[3/7] Bibliographie erstellen (biber)...${NC}"
    biber "$MAIN" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${YELLOW}⚠ Warnung bei der Bibliographie${NC}"
    else
        echo -e "${GREEN}✓ Bibliographie erstellt${NC}"
    fi
    echo ""
    
    # Schritt 4: Zweite LuaLaTeX-Kompilierung
    echo -e "${YELLOW}[4/7] Zweite LuaLaTeX-Kompilierung...${NC}"
    lualatex --shell-escape -interaction=nonstopmode "$MAIN.tex" > /dev/null 2>&1
    echo -e "${GREEN}✓ Zweite Kompilierung abgeschlossen${NC}"
    echo ""
    
    # Schritt 5: Dritte LuaLaTeX-Kompilierung
    echo -e "${YELLOW}[5/7] Dritte LuaLaTeX-Kompilierung...${NC}"
    lualatex --shell-escape -interaction=nonstopmode "$MAIN.tex" > /dev/null 2>&1
    echo -e "${GREEN}✓ Dritte Kompilierung abgeschlossen${NC}"
    echo ""
    
    # Schritt 6: Vierte Kompilierung
    echo -e "${YELLOW}[6/7] Vierte LuaLaTeX-Kompilierung...${NC}"
    lualatex --shell-escape -interaction=nonstopmode "$MAIN.tex" > /dev/null 2>&1
    echo -e "${GREEN}✓ Vierte Kompilierung abgeschlossen${NC}"
    echo ""
    
    # Schritt 7: Prüfen
    echo -e "${YELLOW}[7/7] Prüfe Ausgabe...${NC}"
fi

# === Ergebnis ===
if [ -f "$MAIN.pdf" ]; then
    echo -e "${GREEN}✓ PDF erfolgreich erstellt: $MAIN.pdf${NC}"
    
    # Dateigröße und Seitenzahl anzeigen
    SIZE=$(du -h "$MAIN.pdf" | cut -f1)
    echo -e "${GREEN}  Dateigröße: $SIZE${NC}"
    
    # Seitenzahl (falls pdfinfo verfügbar)
    if command -v pdfinfo &> /dev/null; then
        PAGES=$(pdfinfo "$MAIN.pdf" 2>/dev/null | grep "Pages:" | awk '{print $2}')
        if [ -n "$PAGES" ]; then
            echo -e "${GREEN}  Seiten: $PAGES${NC}"
        fi
    fi
else
    echo -e "${RED}✗ PDF wurde nicht erstellt!${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Kompilierung erfolgreich!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

if [ "$FAST_MODE" = false ]; then
    echo -e "${BLUE}💡 Tipps:${NC}"
    echo "  - Schnelle Kompilierung: ./compile.sh --fast"
    echo "  - Mit Bereinigung:       ./compile.sh --clean"
    echo "  - Auto-Watch-Modus:      ./compile.sh --watch"
    echo "  - Nur bereinigen:        ./clean-latex.sh"
fi
