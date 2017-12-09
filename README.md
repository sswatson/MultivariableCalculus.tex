# MultivariableCalculus.tex

This repository contains source code for a multivariable calculus text used as a part of *Interphase*, a summer program for entering freshmen at MIT. The text was also used in a Fall 2017 section of Brown University's course Math 0350. 

To compile, you need pdfLaTeX and Asymptote (both of which are included in standard TeX installations). To compile, run: 

```
pdflatex MultivariableCalculus.tex
cd asy
asy *-*.asy
cd ../
pdflatex MultivariableCalculus.tex
pdflatex MultivariableCalculus.tex
pdflatex MultivariableCalculus.tex
```