\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{watsonbook}[2017/06/16 watsonbook class]

\PassOptionsToClass{twoside}{report} 
\LoadClassWithOptions{report}

\newif\if@bleedoption
\DeclareOption{bleed}{\@bleedoptiontrue}
\newif\if@prettycodeoption
\DeclareOption{prettycode}{\@prettycodeoptiontrue}
\newif\if@shellescapeoption
\DeclareOption{shellescape}{\@shellescapeoptiontrue}
\ProcessOptions


\RequirePackage[svgnames]{xcolor} 
\RequirePackage{hyperref}
\RequirePackage{url}
\RequirePackage{geometry}
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
\RequirePackage{giambattista}
\RequirePackage{calc} 
\RequirePackage{amsmath}
\RequirePackage{amssymb} 
\RequirePackage{amsthm} 
\RequirePackage{wrapfig} 
\RequirePackage{colonequals} 
\RequirePackage{ifthen}
\RequirePackage{bm}
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

\RequirePackage[T1]{fontenc}
\RequirePackage[scaled=0.8]{beramono}
\RequirePackage{listings}
\RequirePackage{tikz}
\RequirePackage{etoolbox}
% fix marginnote's interaction with wrapfigure:----
\RequirePackage{xpatch} 
\patchcmd\@mn@@@marginnote{\hsize\marginparwidth}{\@parboxrestore\hsize=\marginparwidth}{}{\fail}
\patchcmd\@mn@@@marginnote{\hsize\marginparwidth}{\@parboxrestore\hsize=\marginparwidth}{}{\fail}
% ---------------------------------------


%----PACKAGE CUSTOMIZATION SETUP---------------------
\newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}} % array
\newcolumntype{N}{@{}m{0pt}@{}} % array
\DeclareCaptionFormat{suggested}{{\small #1#2 #3}} % caption
\captionsetup{format=suggested} % caption 
\renewcommand\cftchapafterpnum{\vskip5pt} % tocloft
\renewcommand\cftsecafterpnum{\vskip5pt} % tocloft
\renewcommand\cftsubsecafterpnum{\vskip5pt} % tocloft
\setenumerate{labelsep=3pt,itemsep=0pt,parsep=0pt,topsep=0pt} % enumitem 
\setitemize{labelsep=3pt,itemsep=0pt,parsep=0pt,topsep=0pt} % enumitem
\definecolor{shadecolor}{rgb}{0.92,0.92,0.92} % listings

%--PACKAGE SETUP----------------------------------
%
\definecolor{shadecolor}{rgb}{0.92,0.92,0.92} % listings
\lstdefinelanguage{Julia}%
  {morekeywords={abstract,break,case,catch,const,continue,do,else,elseif,%
      end,export,false,for,function,immutable,import,importall,if,in,%
      macro,module,otherwise,quote,return,switch,true,try,type,struct,mutable,typealias,%
      using,while},%
   sensitive=true,%
   alsoother={},%
   morecomment=[l]\#,%
   morecomment=[n]{\#=}{=\#},%
   morestring=[s]{"}{"},%
   morestring=[m]{'}{'},%
 }[keywords,comments,strings]%
\lstdefinelanguage{text}{}%
% choose between minted (which uses python's pygments)
% and lstlisting for the pythonblock and juliablock environments
\if@prettycodeoption
  \if@shellescapeoption
    \RequirePackage[finalizecache]{minted}
  \else
    \RequirePackage[frozencache]{minted} 
  \fi
  \tcbuselibrary{minted}
  \newcommand{\NewCodeBlockEnvironment}[6]{
    \NewTCBListing{#1}{O{}}{
      title = #2,
      colback = #3,
      colframe = #4, 
      minted language=#5,
      listing only,
      boxrule = 1pt,
      before skip = 8pt, 
      fonttitle=\small\sc\bfseries,
      minted options={autogobble}, 
      fontupper=\small,
      ##1
    }
    \NewTotalTCBox{#6}{ v } {%
      verbatim,%
      boxrule=0.25pt,%
      left=0.25pt,%
      right=0.25pt,%
      colback=#3,%
      colframe=#4}{\mintinline{#5}{##1}%
    }
  }
  \NewCodeBlockEnvironment{juliablock}{Julia}{softred}{red!40!black}{julia}{juliainline}
  \NewCodeBlockEnvironment{pythonblock}{Python}{softblue}{blue!40!black}{python}{pythoninline}
  \NewCodeBlockEnvironment{rblock}{R}{softyellow}{yellow!40!black}{r}{rinline}
  \NewCodeBlockEnvironment{textblock}{Python/Julia/R}{shadecolor}{gray}{text}{textinline}
\else % --- USE LISTINGS INSTEAD OF MINTED ------------------
\tcbuselibrary{listingsutf8}
  \newcommand{\NewCodeBlockEnvironment}[6]{
    \NewTCBListing{#1}{O{}}{
      title = #2,
      colback = #3,
      colframe = #4, 
      listing engine=listings,
      listing only,
      top = 0pt,
      bottom = 0pt, 
      boxrule = 1pt,
      before skip = 8pt, 
      fonttitle=\small\sc\bfseries,
      fontupper=\small,
      listing options = {language=#5,backgroundcolor=\color{#3}},
      ##1
    }
    \NewTotalTCBox{#6}{ v } {%
      verbatim,%
      boxrule=0.25pt,%
      left=0.25pt,%
      right=0.25pt,%
      colback=#3,%
      colframe=#4}{\lstinline[language=#5]^##1^%
    }
  }
  \NewCodeBlockEnvironment{juliablock}{Julia}{softred}{red!40!black}{Julia}{juliainline}
  \NewCodeBlockEnvironment{pythonblock}{Python}{softblue}{blue!40!black}{Python}{pythoninline}
  \NewCodeBlockEnvironment{rblock}{R}{softyellow}{yellow!40!black}{R}{rinline}
  \NewCodeBlockEnvironment{textblock}{Python/Julia/R}{shadecolor}{gray}{text}{textinline}
\fi
\lstset{
  basicstyle       = \ttfamily,
  keywordstyle     = \bfseries\color{blue},
  stringstyle      = \color{magenta},
  commentstyle     = \color{ForestGreen},
  showstringspaces = false,
  backgroundcolor  = \color{shadecolor},
  belowskip        = 2mm
}
%-------------------------------------------------


%--- MATH COMMANDS ---------------------------
\DeclareMathOperator{\arcsec}{arcsec}
\DeclareMathOperator{\cis}{cis}
\DeclareMathOperator{\Real}{Re}
\DeclareMathOperator{\Imag}{Im}
\let\e\relax\DeclareMathOperator{\e}{e}
\newcommand\pd[2]{\frac{\partial #1}{\partial #2}}
\renewcommand{\vec}[1]{\mathbf{#1}}
\newcommand{\R}{\mathbb{R}}
\let\C\relax\newcommand{\C}{\mathbb{C}}
\newcommand{\Z}{\mathbb{Z}}
\let\d\relax\newcommand{\d}{\mathrm{d}}

%----TCOLORBOX SETUP-----------------------------

\definecolor{softblue}{rgb}{0.92, 0.95, 0.99}
\definecolor{softyellow}{rgb}{0.98, 0.98, 0.9}
\definecolor{softseagreen}{rgb}{0.96, 0.995, 0.98}
\definecolor{softred}{rgb}{0.99, 0.92, 0.91}
\definecolor{softbrown}{rgb}{0.97, 0.97, 0.9}

\numberwithin{equation}{section}

\newtcbtheorem[number within=section]{theo}{Theorem}{
  colback=Purple!5,
  colframe=Purple!50!black, %red!35!black,
  fonttitle=\bfseries}{th}
\newtcbtheorem[number within=section]{obs}{Observation}{
  colback=Turquoise!8!white,
  colframe=Turquoise!50!black,
  fonttitle=\bfseries}{obs}
\newtcbtheorem[number within=section]{exercise}{Exercise}{
  colback=softseagreen,
  colframe=SeaGreen,
  fonttitle=\bfseries,
  parbox=false}{exer}
\newcounter{aexercise}
\setcounter{aexercise}{0}
\newtcolorbox{aexercise}[1][]{
  title=Exercise~\thesubsection.\theaexercise, 
  colback=softseagreen,
  colframe=SeaGreen,
  fonttitle=\bfseries,
  code=\stepcounter{aexercise},
  parbox=false, #1}
\newtcbtheorem[number within=section]{example}{Example}{
  enhanced,
  colback=softblue,
  colframe=MidnightBlue,
  fonttitle=\bfseries}{exam}
\newtcbtheorem[number within=section]{defn}{Definition}{colback=Purple!5,
  colframe=Purple,
  fonttitle=\bfseries}{defn}
\newtcolorbox{solution}[1][title=Solution]{
  enhanced,
  breakable,
  parbox=false, 
  colback=softyellow,
  colframe=Orange!75!black,
  fonttitle=\bfseries,
  #1}
\newtcolorbox{pf}[1][title=Proof]{
  enhanced,
  breakable,
  parbox=false, 
  colback=softyellow,
  colframe=Orange!75!black,
  fonttitle=\bfseries,
  #1}

\newcommand*\chapterlabel{}
\titleformat{\chapter}
  {\gdef\chapterlabel{}
   \normalfont\sffamily\Huge\bfseries\scshape}
  {\gdef\chapterlabel{\thechapter\ }}{0pt}
  {\begin{tikzpicture}[remember picture,overlay]
    \node[yshift=-3cm] at (current page.north west)
      {\begin{tikzpicture}[remember picture, overlay]
        \draw[fill=softblue] (0,0) rectangle
          (\paperwidth,3cm);
        \node[anchor=east,xshift=.9\paperwidth,rectangle,
              rounded corners=20pt,inner sep=11pt,
              fill=MidnightBlue]
              {\color{white}\chapterlabel#1};
       \end{tikzpicture}
      };
   \end{tikzpicture}
  }
\titlespacing*{\chapter}{0pt}{50pt}{-60pt}

\titleformat{\section}
  {\addtolength{\titlewidth}{2pc}\normalfont\Large\sffamily\bfseries}
  {\colorbox{MidnightBlue}{\parbox{2cm}{\strut\color{white}\hfill\thesection}}}
  {1em}{#1}
  [{\titleline*[l]{\color{MidnightBlue}\titlerule[2pt]}}]
\titleformat{\subsection}
  {\addtolength{\titlewidth}{2pc}\bfseries\scshape}
  {\colorbox{MidnightBlue}{\parbox{2cm}{\strut\color{white}\hfill\thesubsection}}}
  {1em}{#1}
  [{\titleline*[l]{\color{MidnightBlue}\titlerule[2pt]}}]

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

%--SIDE NOTES-------------------------------------
\newlength{\marginvoffset} 
\DeclareDocumentCommand{\sidenote}{O{rectangle,thick,black,text width =
    17.5mm,draw=MidnightBlue,fill=softblue,rounded corners=0.5mm} m O{0pt}}{%
  \setlength{\marginvoffset}{#3 - 12pt}%
  \normalmarginpar %
  \marginnote[{%
    \makebox[0pt][r]{%
      \scriptsize \tikz \node at (0,-1) [#1]{#2};%
    }%
  }]{{%
      \makebox[0pt][l]{%
        \scriptsize \tikz \node at (0,-1) [#1]{#2};%
      }%
    }}[\marginvoffset]%
}


% example: \authornote{ssw}{green}{Add reference here}
\DeclareDocumentCommand{\authornote}{m m m O{0pt}}{%
       \setlength{\marginvoffset}{#4 - 12pt}%
       \reversemarginpar%
       \marginnote{%
          \makebox[0pt][l]{%
            \scriptsize \tikz \node at (0,-1) [rectangle,thick,black,text width = %
       17.5mm,draw=#2,rounded corners=0.5mm,fill=#2]{\textcolor{white}{#1: #3}};%
          }%
          }[\marginvoffset]%
	  }

\newcommand{\bang}[1]{\marginnote{ \Huge \color{DarkRed} !!!}[#1]}
	  
\newcommand{\datemarker}[1]{\sidenote[rectangle,text width =
  1.75cm,draw,fill=black!25,rounded corners]{\centerline{#1}}}

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


%----- BY-HAND WRAPFIGURE-TYPE COMMAND-------

\newlength{\myparskiplength}

% arguments for insetfiguremanual:
% width of first box (optional)
% width of second box (optional)
% alignment, c, t, or b (optional)
% text to appear in first box
% figure to appear in second box
% text to appear after figure 
\NewDocumentCommand{\insetfiguremanual}{O{0.7\textwidth}O{0.29\textwidth}O{t}+m+m+m}
{\begin{minipage}[#3]{#1} \parskip = \myparskiplength
#4
\end{minipage} \hfill
\begin{minipage}[#3]{#2}
\centering
\raisebox{\dimexpr -\height + 1.5ex\relax}{#5}
#6
\end{minipage}
}

% arguments for insetfigure
% text content for first box
% figure content for second box
% alignment: c, t, or b (optional) 
% spacing between two boxes (optional)
% text to appear after figure (Optional)
\newsavebox{\insetfiguresavebox}%
\newlength{\myfigurewidth}%
\NewDocumentCommand{\insetfigure}{+m+m+O{}O{t}O{16pt}}{%
  \begin{lrbox}{\insetfiguresavebox}%
    #2%
  \end{lrbox}%
  \setlength{\myfigurewidth}{\wd\insetfiguresavebox}%
  \insetfiguremanual
  [\textwidth - \myfigurewidth - #5]
  [\myfigurewidth]
  [#4]
  {#1}
  {\usebox{\insetfiguresavebox}}
  {#3}
}
