
BASENAME=MultivariableCalculus

all : pdf 3D

light : lightpdf light3D

lightpdf : 
	lualatex --shell-escape -interaction=nonstopmode -synctex=1 $(BASENAME).tex

light3D: $(BASENAME).tex
	lualatex -jobname="$(BASENAME)-3D" --shell-escape -interaction=nonstopmode -synctex=1 "\PassOptionsToClass{3D}{watsonbook}\input{$(BASENAME).tex}"

3D : $(BASENAME).tex
	latexmk -pdf -pdflatex='lualatex %O --shell-escape -interaction=nonstopmode -synctex=1 "\PassOptionsToClass{3D}{watsonbook}\input{%S}"' -jobname="$(BASENAME)-3D" $(BASENAME).tex

pdf :
	latexmk -pdf -pdflatex='lualatex %O --shell-escape -interaction=nonstopmode -synctex=1 %S' $(BASENAME).tex
