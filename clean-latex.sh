#!/bin/bash
# ===================================================================
# LaTeX Bereinigungsskript
# Entfernt alle temporären Build-Dateien
# ===================================================================

# Farben für Ausgabe
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🧹 Lösche LaTeX Cache-Dateien...${NC}"

# Zähler für gelöschte Dateien
count=0

# Hauptdokument-spezifische Dateien
extensions=("aux" "bbl" "bcf" "blg" "run.xml" "log" "out" "toc" "lof" "lot" 
           "fls" "fdb_latexmk" "synctex.gz" "xmpdata" "xwm"
           "acn" "acr" "alg" "glg" "glo" "gls" "ist" "nlg" "not" "ntn" "slg" "syg" "syi")

for ext in "${extensions[@]}"; do
    files=$(find . -maxdepth 1 -name "*.$ext" 2>/dev/null)
    if [ -n "$files" ]; then
        rm -f *.$ext
        count=$((count + $(echo "$files" | wc -l)))
    fi
done

# Minted Cache löschen
if [ -d "build/minted-cache" ]; then
    echo -e "${YELLOW}  Lösche Minted-Cache...${NC}"
    rm -rf build/minted-cache/*
    count=$((count + 1))
fi

echo -e "${GREEN}✅ $count Datei(en) gelöscht.${NC}"
echo ""
echo -e "${GREEN}💡 Tipp: Kompiliere mit ./compile.sh${NC}"