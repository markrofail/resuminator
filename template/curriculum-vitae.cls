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
\usepackage[hmargin=1.25cm, vmargin=0.75cm]{geometry}
\usepackage[hidelinks]{hyperref}
\usepackage{fancyhdr}
\usepackage{clrstrip}
\usepackage{enumitem}
\usepackage{titlesec}
\usepackage{fontspec}
\usepackage{fontawesome5}

% Publications
\usepackage{cite}
\renewcommand\refname{\vskip -1.5cm}

% Color definitions
\usepackage[usenames,dvipsnames]{xcolor} 
\definecolor{date}{HTML}{666666} 
\definecolor{primary}{HTML}{333333} 
\definecolor{headings}{HTML}{000000}
\definecolor{subheadings}{HTML}{333333}

% Set main fonts
\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Color=primary]{Helvetica}
\setsansfont[Scale=MatchLowercase,Mapping=tex-text]{Helvetica Neue}

% Date command
\usepackage[absolute]{textpos}
\usepackage[UKenglish]{isodate}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}
\textblockorigin{0mm}{5mm}
\newcommand{\lastupdated}{\begin{textblock}{60}(155,0)
\color{date}\fontspec{Helvetica Neue Light}\fontsize{10pt}{10pt}\selectfont 
Last Updated on
\today
\end{textblock}}

% Name command
\newcommand{\namesection}[4]{
\raggedright{
  \color{headings}
  \sffamily
  \fontspec{Helvetica Light}\fontsize{40pt}{10cm}\selectfont #1  
  \fontspec{Helvetica Light}\selectfont #2
  % \hfill
  % \fontspec{Helvetica}\fontsize{11pt}{14pt}\selectfont #3 
  } 
\raggedright{
  \begin{colorstrip}{black}[inner=8pt]
    \color{white}
    \fontspec{Helvetica}\fontsize{11pt}{14pt}\selectfont #4
  \end{colorstrip}
  }
}

% Section seperators 
\titlespacing*{\section}{0pt}{0.1\baselineskip}{0.2\baselineskip}
\titlespacing{\subsection}{0pt}{\parskip}{-\parskip}
\titlespacing{\subsubsection}{0pt}{\parskip}{-\parskip}

% Headings command
\titleformat{\section}{\color{headings}
\scshape\fontspec{Helvetica Light}\fontsize{16pt}{24pt}\selectfont \raggedright}{} {0em}{}

% Subeadings command
\titleformat{\subsection}{\color{subheadings}
\fontspec{Helvetica}\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase}{}{0em}{}

\newcommand{\runsubsection}[1]{\color{subheadings}
\fontspec{Helvetica}\fontsize{12pt}{12pt}\selectfont\bfseries {#1} \normalfont}

% Descriptors command
\newcommand{\descript}[1]{\color{subheadings}\raggedright\scshape\fontspec{Helvetica}\fontsize{11pt}{13pt}\selectfont {#1 \\} \normalfont}

% Location command
\newcommand{\location}[1]{\color{headings}\raggedright\scshape\fontspec{Helvetica}\fontsize{10pt}{12pt}\selectfont {#1\\} \normalfont}

% Section seperators command
\newcommand{\sectionsep}[0]{\vspace{8pt}}

% Bullet Lists with fewer gaps command
\newenvironment{tightemize}{
\vspace{-\topsep}\begin{itemize}\itemsep1pt \parskip0pt \parsep0pt}
{\end{itemize}\vspace{-\topsep}}
