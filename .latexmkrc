# .latexmkrc – Latexmk-Konfiguration für dieses Projekt
# Erzwingt LuaLaTeX als Compiler

$pdf_mode = 4;           # 4 = lualatex
$lualatex = 'lualatex --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$pdf_previewer = 'start %S';
$clean_ext   = 'bbl run.xml fls fdb_latexmk synctex.gz';
