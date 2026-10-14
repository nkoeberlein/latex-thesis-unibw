# fonts/

Die Vorlage nutzt standardmäßig **Libertinus Serif** (in TeX Live enthalten,
SIL Open Font License) – dieselbe Schrift wie die Typst-Version. Hier muss nichts liegen.

## Optional: Bookerly

Wer Bookerly rechtmäßig besitzt, kann die vier Dateien hier ablegen:

```
Bookerly-Regular.ttf
Bookerly-Bold.ttf
Bookerly-RegularItalic.ttf
Bookerly-BoldItalic.ttf
```

`default_style/setup.tex` erkennt sie automatisch. Bookerly ist eine proprietäre Schrift
von Amazon und darf **nicht** weitergegeben werden – `.gitignore` verhindert, dass sie
versehentlich committet wird.
