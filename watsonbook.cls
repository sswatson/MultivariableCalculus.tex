\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{watsonbook}[2017/06/16 watsonbook class]

\PassOptionsToClass{twoside}{report} 
\LoadClassWithOptions{report}

\newif\if@threedoption
\DeclareOption{3D}{\@threedoptiontrue}
\newif\if@bleedoption
\DeclareOption{bleed}{\@bleedoptiontrue}
\newif\if@prettycodeoption
\DeclareOption{prettycode}{\@prettycodeoptiontrue}
\newif\if@shellescapeoption
\DeclareOption{shellescape}{\@shellescapeoptiontrue}
\newif\if@juliaoption
\DeclareOption{julia}{\@juliaoptiontrue}
\newif\if@jlminoption
\DeclareOption{jlmin}{\@jlminoptiontrue}
\ProcessOptions

\RequirePackage[svgnames]{xcolor} 
\RequirePackage{hyperref}
\RequirePackage{url}
\RequirePackage{geometry}
\RequirePackage{cprotect}
\if@bleedoption
  \geometry{papersize={8.625in,11.25in},
    layoutsize={8.875in,11in},
    bindingoffset=0.375in, 
    layoutoffset={-0.125in,0.125in},
    margin=1in,
    marginpar=0.5in,
    marginparsep= -6.925mm, % 2.6mm + 0.125 in
    twoside}
  \else
  \geometry{
    margin=1in,
    marginpar=0.5in,
    marginparsep= 2.6mm, 
    twoside}
\fi
\RequirePackage{iftex}
\if@juliaoption \RequirePackage{juliatex} \fi
\if@jlminoption \RequirePackage[minimal]{juliatex} \fi

\RequirePackage{calc} 
\RequirePackage{amsmath}
\RequirePackage{amssymb} 
\RequirePackage{amsthm} 
\RequirePackage{wrapfig} 
\RequirePackage{colonequals} 
\RequirePackage{ifthen}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage[labelfont=bf,labelsep=none,justification=RaggedRight]{caption}
\RequirePackage{asymptote}
\RequirePackage{xparse}
\RequirePackage[skins,theorems,breakable,raster,listings,xparse]{tcolorbox}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{marginnote}
\RequirePackage{tocloft}
\RequirePackage[explicit,calcwidth]{titlesec}

%\RequirePackage[T1]{fontenc}
%\RequirePackage[scaled=0.8]{beramono}
\RequirePackage{listings}
\RequirePackage{tikz}
\RequirePackage{etoolbox}


%----PACKAGE CUSTOMIZATION SETUP---------------------
\newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}} % array
\newcolumntype{N}{@{}m{0pt}@{}} % array
\DeclareCaptionFormat{suggested}{{\small #1#2 #3}} % caption
\captionsetup{hypcap=false, format=suggested} % caption 
\renewcommand\cftchapafterpnum{\vskip5pt} % tocloft
\renewcommand\cftsecafterpnum{\vskip5pt} % tocloft
\renewcommand\cftsubsecafterpnum{\vskip5pt} % tocloft
\definecolor{shadecolor}{rgb}{0.92,0.92,0.92} % listings

\RequirePackage{codeboxes} 
\RequirePackage{mathmacros}
\RequirePackage{enumboxes}

%----TCOLORBOX SETUP-----------------------------

\RequirePackage{theoremboxes}
\RequirePackage{sectionheadings}

%----ENVIRONMENT HIDING--------------------------

\RequirePackage{hiding}

%----INSETFIGS-----------------------------------

\RequirePackage{insetfigure}

% ---- CUSTOM FORMATTING COMMANDS --------------------

\newcounter{intld}
	\setcounter{intld}{0}
\newcounter{comp}
	\setcounter{comp}{0}
\newcounter{prob}
	\setcounter{prob}{1}
\newcounter{subitm}
        \setcounter{subitm}{1}

\newcommand\subitm{(\alph{subitm})\quad\stepcounter{subitm}}
\newcommand{\pairofprobs}[2]{\makebox[0.5\textwidth][l]{\subitm #1}\subitm #2}

\RequirePackage{sidenotes} 

%-----------------------------------------------
       
\usepackage{color}
\definecolor{dg}{RGB}{2,101,15}
\definecolor{dr}{RGB}{80,15,40}

%----- SPACING CUSTOMIZATIONS -----------------

\parindent = 0.0 in
\parskip = 0.2 in
% \reversemarginpar % Set margin notes in left margin 
\setlength{\wrapoverhang}{\marginparwidth} % wrapfigure spillover

%----- TITLE FONT CUSTOMIZATION ---------------

\DeclareFixedFont{\titlefont}{T1}{ppl}{b}{it}{32}
\DeclareFixedFont{\subtitlefont}{T1}{ppl}{b}{it}{18pt}

%----- APPENDIX SUBSECTION ---------------------

\newcommand{\asubsection}[1]{
\subsection*{Section \ref{#1}}
\renewcommand{\thesubsection}{A.\ref{#1}}
\setcounter{aexercise}{0}
}

\newcommand{\NewProblemBox}[4]{
\DeclareTColorBox{#1}{O{}}{
  title=#2 \itm, 
  colback=#3,
  separator sign none,
  parbox = false,
  before skip = 8pt, 
  colframe = #4, 
  fonttitle=\bfseries,
  ##1}
}

% ----- FONTS ------------------------------
\RequirePackage{newunicodechar}
\RequirePackage{giambattista}
\ifLuaTeX
  \setmainfont{TeX Gyre Pagella}
  \setsansfont{Latin Modern Sans}
  \setmonofont[Scale=0.8,Ligatures=NoCommon]{Cavalcade Mono}
%  \setmonofont[Scale=0.8,Ligatures=NoCommon]{Noto Sans Mono SemiBold}
%  \newfontfamily{\alternatemonofont}{DejaVu Sans Mono}
%  \newfontfamily{\alternatemonofonttwo}{Cavalcade}
%  \newunicodechar{≠}{{\alternatemonofont ≠}}
% \newunicodechar{∇}{{\alternatemonofont ∇}}
%  \newunicodechar{ℒ}{{\alternatemonofonttwo ℒ}}
\fi

% ----- JUPYTER NOTEBOOK OUTPUT ------------
\declarecommand{\giturl}{}
\DeclareDocumentCommand{\jupyternotebook}{m O{}}{\sidenote{\fontsize{6}{6}\href{\giturl #1.ipynb}{\texttt{#1.ipynb}}}[#2]}
\newcommand{\closejupyternotebook}{}

% ----- SPECIAL SYMBOLS --------------------

\DeclareRobustCommand{\tabkey}{%
  \begingroup\normalfont
  \raisebox{0pt}{\includegraphics[height=\fontcharht\font`\e]{tabkey-symbol.pdf}}
  \endgroup
}