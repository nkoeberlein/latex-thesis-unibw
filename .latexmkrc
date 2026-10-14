# .latexmkrc – Latexmk-Konfiguration für dieses Projekt
# Aufruf: latexmk 1Main.tex   (oder: latexmk Skript.tex)
# Erledigt LuaLaTeX, Biber und makeglossaries in der richtigen Reihenfolge.

$pdf_mode = 4;           # 4 = lualatex
$lualatex = 'lualatex --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$clean_ext = 'bbl run.xml fls fdb_latexmk synctex.gz acn acr alg glg glo gls ist slg syg syi';

# Glossar, Abkürzungen und Symbole (glossaries-Paket) automatisch bauen
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
add_cus_dep('syg', 'syi', 0, 'run_makeglossaries');
sub run_makeglossaries {
  my ($base_name, $path) = fileparse($_[0]);
  my @args = ('-q', $base_name);
  unshift @args, '-d', $path if $path ne '' && $path ne './';
  return system('makeglossaries', @args);
}
push @generated_exts, 'glo', 'gls', 'glg', 'acn', 'acr', 'alg', 'syg', 'syi', 'slg';
