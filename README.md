# MultivariableCalculus.tex

This repository contains source code for a multivariable calculus text used as a part of *Interphase*, a summer program for entering freshmen at MIT.

To compile, you need LuaLaTeX and Asymptote (both of which are included in standard TeX installations). You also need to install the latex packages and class files at my [latex-setup](https://github.com/sswatson/latex-setup) repo.

```
lualatex --shell-escape MultivariableCalculus.tex
cd asy
asy *-*.asy
cd ../
lualatex --shell-escape MultivariableCalculus.tex
lualatex --shell-escape MultivariableCalculus.tex
lualatex --shell-escape MultivariableCalculus.tex
```