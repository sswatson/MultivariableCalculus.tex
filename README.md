# MultivariableCalculus.tex

This repository contains source code for a multivariable calculus text used as a part of *Interphase*, a summer program for entering freshmen at MIT, and later an Honors Calculus course at Brown University.

To compile, you need pdflatex and Asymptote (both of which are included in standard TeX installations). To compile, run: 

```
pdflatex MultivariableCalculus.tex
cd asy
asy *-*.asy
cd ../
pdflatex MultivariableCalculus.tex
pdflatex MultivariableCalculus.tex
pdflatex MultivariableCalculus.tex
```