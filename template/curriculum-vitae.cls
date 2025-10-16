% Intro Options
\ProvidesClass{curriculum-vitae}[2014/04/30 CV class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

% Package Imports
\usepackage[hmargin=1.0cm, vmargin=0.5cm]{geometry}
\usepackage[hidelinks]{hyperref}
\usepackage{fancyhdr}
\usepackage{clrstrip}
\usepackage{enumitem}
\usepackage{titlesec}
\usepackage{fontspec}
\usepackage{fontawesome5}
\usepackage[default,scale=0.95]{opensans}

% Publications
\usepackage{cite}
\renewcommand\refname{\vskip -1.5cm}

% Color definitions
\usepackage[usenames,dvipsnames]{xcolor} 
\definecolor{date}{HTML}{666666} 
\definecolor{primary}{HTML}{333333} 
\definecolor{headings}{HTML}{000000}
\definecolor{subheadings}{HTML}{333333}

% Date command
\usepackage[absolute]{textpos}
\usepackage[UKenglish]{isodate}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}
\textblockorigin{0mm}{5mm}
\newcommand{\lastupdated}{\begin{textblock}{60}(155,0)
\color{date}\fontsize{10pt}{10pt}\selectfont
Last Updated on
\today
\end{textblock}}

% Name command
\newcommand{\namesection}[4]{
\raggedright{
  \color{headings}
  \fontsize{40pt}{10cm}\selectfont #1 #2
  % \hfill
  % \fontsize{11pt}{14pt}\selectfont #3 
  \vspace{6pt}
  } 
\raggedright{
  \begin{colorstrip}{white}[inner=8pt]
    \color{black}
    \fontsize{11pt}{14pt}\selectfont #4
  \end{colorstrip}
  }
}

% Section seperators
\titlespacing*{\section}{0pt}{0.05\baselineskip}{0.1\baselineskip}
\titlespacing{\subsection}{0pt}{\parskip}{-\parskip}
\titlespacing{\subsubsection}{0pt}{\parskip}{-\parskip}

% Headings command
\titleformat{\section}{\color{headings}
\scshape\fontsize{16pt}{24pt}\selectfont \raggedright}{} {0em}{}

% Subeadings command
\titleformat{\subsection}{\color{subheadings}
\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase}{}{0em}{}

\newcommand{\runsubsection}[1]{\color{subheadings}
\fontsize{12pt}{12pt}\selectfont\bfseries {#1} \normalfont}

% Descriptors command
\newcommand{\descript}[1]{\color{subheadings}\raggedright\bfseries\scshape\fontsize{11pt}{13pt}\selectfont {#1 \\} \normalfont}

% Location command
\newcommand{\location}[1]{\color{headings}\raggedright\scshape\fontsize{10pt}{12pt}\selectfont {#1\\} \normalfont}

% Section seperators command
\newcommand{\sectionsep}[0]{\vspace{4pt}}

% Bullet Lists with fewer gaps command
\newenvironment{tightemize}{
\vspace{-\topsep}\begin{itemize}[leftmargin=16pt, itemsep=0pt, parsep=0pt]}
{\end{itemize}\vspace{-\topsep}}
