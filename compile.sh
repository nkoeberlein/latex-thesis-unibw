#!/bin/bash
# =============================================================
# LaTeX-Kompilierungsskript – dünner Wrapper um latexmk
# Die eigentliche Konfiguration steht in .latexmkrc
# =============================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

MAIN="1Main"
CLEAN_FIRST=false
FAST_MODE=false

usage() {
    echo "Verwendung: $0 [OPTIONEN] [DATEI]"
    echo ""
    echo "Optionen:"
    echo "  --clean    Erst bereinigen, dann kompilieren"
    echo "  --fast     Schnelle Vorschau (nur 1× LuaLaTeX, keine Referenzen)"
    echo "  --help     Diese Hilfe anzeigen"
    echo ""
    echo "Beispiele:"
    echo "  $0              # 1Main.tex vollständig bauen (empfohlen)"
    echo "  $0 Skript       # Exposé bauen"
    echo "  $0 --fast       # Schnelle Vorschau"
    exit 0
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --clean) CLEAN_FIRST=true; shift ;;
        --fast)  FAST_MODE=true;  shift ;;
        --help)  usage ;;
        -*) echo -e "${RED}Unbekannte Option: $1${NC}"; usage ;;
        *) MAIN="${1%.tex}"; shift ;;
    esac
done

if [ "$CLEAN_FIRST" = true ]; then
    echo -e "${YELLOW}Bereinige Build-Dateien...${NC}"
    ./clean-latex.sh
fi

if [ "$FAST_MODE" = true ]; then
    echo -e "${YELLOW}Schnelle Vorschau (1× LuaLaTeX)...${NC}"
    lualatex --shell-escape -interaction=nonstopmode -file-line-error "$MAIN.tex" > /dev/null
elif command -v latexmk &> /dev/null; then
    echo -e "${YELLOW}Vollständige Kompilierung mit latexmk...${NC}"
    latexmk -silent "$MAIN.tex"
else
    echo -e "${YELLOW}latexmk nicht gefunden – manuelle Reihenfolge...${NC}"
    LUA="lualatex --shell-escape -interaction=nonstopmode -file-line-error"
    $LUA "$MAIN.tex" > /dev/null
    makeglossaries "$MAIN" > /dev/null 2>&1
    biber "$MAIN" > /dev/null 2>&1
    $LUA "$MAIN.tex" > /dev/null
    $LUA "$MAIN.tex" > /dev/null
fi

# lualatex liefert auch bei Warnungen Exit-Code 1 – daher Log auf echte Fehler prüfen
if grep -q "^! \|^\./.*:[0-9]*: " "$MAIN.log" 2>/dev/null; then
    echo -e "${RED}✗ Fehler gefunden:${NC}"
    grep -A2 "^! \|^\./.*:[0-9]*: " "$MAIN.log" | head -20
    echo "Vollständiges Log: $MAIN.log"
    exit 1
fi

if [ -f "$MAIN.pdf" ]; then
    echo -e "${GREEN}✓ PDF erstellt: $MAIN.pdf ($(du -h "$MAIN.pdf" | cut -f1))${NC}"
else
    echo -e "${RED}✗ Kein PDF erstellt – Log prüfen: $MAIN.log${NC}"
    exit 1
fi
