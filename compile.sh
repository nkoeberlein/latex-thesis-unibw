#!/bin/bash
# =============================================================
# LaTeX Kompilierungsskript für LuaLaTeX
# =============================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

MAIN="1Main"
CLEAN_FIRST=false
FAST_MODE=false

usage() {
    echo "Verwendung: $0 [OPTIONEN]"
    echo ""
    echo "Optionen:"
    echo "  --clean    Erst bereinigen, dann kompilieren"
    echo "  --fast     Schnelle Kompilierung (nur 1× LuaLaTeX, keine Referenzen)"
    echo "  --help     Diese Hilfe anzeigen"
    echo ""
    echo "Beispiele:"
    echo "  $0           # Vollständige Kompilierung (empfohlen)"
    echo "  $0 --fast    # Schnelle Vorschau"
    echo "  $0 --clean   # Erst bereinigen, dann kompilieren"
    exit 0
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --clean) CLEAN_FIRST=true; shift ;;
        --fast)  FAST_MODE=true;  shift ;;
        --help)  usage ;;
        *) echo -e "${RED}Unbekannte Option: $1${NC}"; usage ;;
    esac
done

if [ "$CLEAN_FIRST" = true ]; then
    echo -e "${YELLOW}Bereinige Build-Dateien...${NC}"
    ./clean-latex.sh
    echo ""
fi

echo -e "${GREEN}========================================${NC}"
if [ "$FAST_MODE" = true ]; then
    echo -e "${GREEN}Schnelle LaTeX Kompilierung (1×)...${NC}"
else
    echo -e "${GREEN}Vollständige LaTeX Kompilierung (3×)...${NC}"
fi
echo -e "${GREEN}========================================${NC}"
echo ""

run_lualatex() {
    lualatex --shell-escape -interaction=nonstopmode "$MAIN.tex" > /dev/null 2>&1
    # Prüfe auf echte fatale Fehler im Log (nicht nur den Exit-Code, da
    # lualatex auch bei Warnungen Exit-Code 1 zurückgibt)
    if grep -q "^! " "$MAIN.log" 2>/dev/null; then
        echo -e "${RED}✗ Fataler Fehler gefunden:${NC}"
        grep "^! " "$MAIN.log" | head -10
        echo ""
        echo "Vollständiges Log: $MAIN.log"
        exit 1
    fi
    if [ ! -f "$MAIN.pdf" ]; then
        echo -e "${RED}✗ Kein PDF erstellt — Log prüfen: $MAIN.log${NC}"
        exit 1
    fi
}

if [ "$FAST_MODE" = true ]; then
    echo -e "${YELLOW}[1/1] LuaLaTeX...${NC}"
    run_lualatex
    echo -e "${GREEN}✓ Fertig${NC}"
else
    echo -e "${YELLOW}[1/5] Erste LuaLaTeX-Kompilierung...${NC}"
    run_lualatex
    echo -e "${GREEN}✓ OK${NC}"
    echo ""

    echo -e "${YELLOW}[2/5] Glossar (makeglossaries)...${NC}"
    makeglossaries "$MAIN" > /dev/null 2>&1 && echo -e "${GREEN}✓ OK${NC}" || echo -e "${YELLOW}⚠ Warnung (oft ignorierbar)${NC}"
    echo ""

    echo -e "${YELLOW}[3/5] Bibliographie (biber)...${NC}"
    biber "$MAIN" > /dev/null 2>&1 && echo -e "${GREEN}✓ OK${NC}" || echo -e "${YELLOW}⚠ Warnung${NC}"
    echo ""

    echo -e "${YELLOW}[4/5] Zweite LuaLaTeX-Kompilierung...${NC}"
    run_lualatex
    echo -e "${GREEN}✓ OK${NC}"
    echo ""

    echo -e "${YELLOW}[5/5] Dritte LuaLaTeX-Kompilierung (Referenzen auflösen)...${NC}"
    run_lualatex
    echo -e "${GREEN}✓ OK${NC}"
    echo ""
fi

if [ -f "$MAIN.pdf" ]; then
    SIZE=$(du -h "$MAIN.pdf" | cut -f1)
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}✓ PDF erstellt: $MAIN.pdf ($SIZE)${NC}"
    if command -v pdfinfo &> /dev/null; then
        PAGES=$(pdfinfo "$MAIN.pdf" 2>/dev/null | grep "Pages:" | awk '{print $2}')
        [ -n "$PAGES" ] && echo -e "${GREEN}  Seiten: $PAGES${NC}"
    fi
    echo -e "${GREEN}========================================${NC}"
    echo ""
    if [ "$FAST_MODE" = false ]; then
        echo -e "${BLUE}💡 Schnellere Vorschau: ./compile.sh --fast${NC}"
    fi
else
    echo -e "${RED}✗ PDF wurde nicht erstellt!${NC}"
    exit 1
fi
