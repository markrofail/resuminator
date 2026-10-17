%% resume.cls: one-page CV with a sidebar, a main column and a timeline divider.
%% Compile with XeLaTeX. Fonts (Montserrat, Lato) and icons ship with TeX Live.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2026/10/17 Two-column CV with a timeline divider]
\RequirePackage{fix-cm} % scalable math fonts, so the 8.5pt base size raises no warnings
\LoadClass{article}

\RequirePackage[a4paper, top=15mm, bottom=13mm, left=18mm, right=18mm]{geometry}
\RequirePackage{fontspec}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\RequirePackage{enumitem}
\RequirePackage{fontawesome5}
\RequirePackage[hidelinks]{hyperref}

\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}

%% ---- palette ---------------------------------------------------------------
\definecolor{ink}{HTML}{333333}
\definecolor{strong}{HTML}{222222}
\definecolor{muted}{HTML}{7A7A7A}
\definecolor{hairline}{HTML}{C8C8C8}
\definecolor{dot}{HTML}{8C8C8C}

%% ---- type ------------------------------------------------------------------
\setmainfont{Carlito}[
    Extension      = .ttf,
    UprightFont    = *-Regular,
    BoldFont       = *-Bold,
    ItalicFont     = *-Italic,
    BoldItalicFont = *-BoldItalic]
% letter-spacing stays under ~0.1em: wider gaps make text extractors (and ATS) split words
\newfontfamily\namefont{Montserrat}[Extension = .otf, UprightFont = *-Light, LetterSpace = 2]
\newfontfamily\headingfont{Montserrat}[Extension = .otf, UprightFont = *-Regular, LetterSpace = 4]
\newfontfamily\entryfont{Montserrat}[Extension = .otf, UprightFont = *-SemiBold]

\renewcommand\normalsize{\fontsize{8.5}{12.3}\selectfont}
\newcommand\sidebarsize{\fontsize{8}{10.8}\selectfont}
\newcommand\metasize{\fontsize{7.8}{10.8}\selectfont}

\AtBeginDocument{\normalsize\color{ink}}

%% ---- dimensions --------------------------------------------------------------
\newlength\cvsidewidth   \setlength\cvsidewidth{40mm}
\newlength\cvgap         \setlength\cvgap{13mm}
\newlength\cvrulewidth   \setlength\cvrulewidth{0.4pt}
\newlength\cvdotradius   \setlength\cvdotradius{3.2pt}
\newlength\cvheaderskip  \setlength\cvheaderskip{7.5mm}
\newlength\cvsectionskip \setlength\cvsectionskip{4.5mm}
\newlength\cventryskip   \setlength\cventryskip{3.2mm}
\newlength\cvjobskip     \setlength\cvjobskip{4mm}
\newlength\cvbodyheight

%% ---- header (A, B, C) ----------------------------------------------------------
\newsavebox\cvheaderbox

% \cvheader{first}{last}{job title}{\cvcontact rows}
\newcommand\cvheader[4]{%
    \sbox\cvheaderbox{\begin{minipage}{\textwidth}%
        \begin{minipage}[c]{0.6\textwidth}%
            {\fontsize{26}{28}\selectfont\color{strong}\namefont #1 #2}\par
            \vspace{3mm}%
            {\fontsize{10}{12}\selectfont\color{muted}\headingfont #3}%
        \end{minipage}%
        \hfill
        \begin{minipage}[c]{0.38\textwidth}%
            \raggedleft\metasize
            \begin{tabular}{@{}r@{\hspace{2mm}}c@{}}#4\end{tabular}%
        \end{minipage}\par
        \vspace{5.5mm}%
        {\color{hairline}\rule{\textwidth}{\cvrulewidth}}%
    \end{minipage}}%
    \noindent\usebox\cvheaderbox\par
    \vspace{\cvheaderskip}%
    % whatever the header leaves is the body's to fill, minus slack for interline glue
    \setlength\cvbodyheight{\dimexpr\textheight-\ht\cvheaderbox-\dp\cvheaderbox-\cvheaderskip-3pt\relax}%
}

% \cvcontact[url]{icon}{text}: one right-aligned row with its icon in a fixed column
\newcommand\cvcontact[3][]{%
    \if\relax\detokenize{#1}\relax #3\else\href{#1}{#3}\fi
    & \makebox[1.1em][c]{\color{black}#2}\\%
}

%% ---- columns (D, E, F) -----------------------------------------------------------
\newsavebox\cvsidebox
\newsavebox\cvmainbox
\newif\ifcvfirst
\newif\ifcvafterheading

\newenvironment{cvsidebar}{%
    \global\setbox\cvsidebox\hbox\bgroup
    \begin{minipage}[t]{\cvsidewidth}\cvfirsttrue\sidebarsize\raggedright
}{%
    \par\vskip-\lastskip
    \end{minipage}\egroup
}

\newenvironment{cvmain}{%
    \global\setbox\cvmainbox\hbox\bgroup
    \begin{minipage}[t]{\dimexpr\textwidth-\cvsidewidth-\cvgap\relax}\cvfirsttrue\raggedright
}{%
    \par\vskip-\lastskip
    \end{minipage}\egroup
}

\newcommand\cvcheckfit[2]{%
    \typeout{resume: #1 column uses \the\dimexpr\ht#2+\dp#2\relax\space of \the\cvbodyheight}%
    \ifdim\dimexpr\ht#2+\dp#2\relax>\cvbodyheight
        \ClassWarningNoLine{resume}{#1 column overflows the page by
            \the\dimexpr\ht#2+\dp#2-\cvbodyheight\relax}%
    \fi
}

% \cvbody: places both columns with the divider running to the bottom of the page
\newcommand\cvbody{%
    \cvcheckfit{Sidebar}\cvsidebox
    \cvcheckfit{Main}\cvmainbox
    \par\noindent
    \usebox\cvsidebox
    \hspace{\dimexpr0.5\cvgap-0.5\cvrulewidth\relax}%
    {\color{hairline}\vrule width \cvrulewidth height \ht\cvsidebox
        depth \dimexpr\cvbodyheight-\ht\cvsidebox\relax}%
    \hspace{\dimexpr0.5\cvgap-0.5\cvrulewidth\relax}%
    \usebox\cvmainbox\par
}

%% ---- components ------------------------------------------------------------------
% \cventrygap{length}: space before an entry, except the first one under a heading
\newcommand\cventrygap[1]{%
    \par\ifcvafterheading\global\cvafterheadingfalse\else\addvspace{#1}\fi
}

% 1. section heading: grey title case; a hairline separates it from the previous section
\newcommand\cvsection[1]{%
    \par\ifcvfirst\global\cvfirstfalse\else
        \addvspace{\cvsectionskip}%
        {\color{hairline}\hrule height \cvrulewidth}%
        \vspace{\cvsectionskip}%
    \fi
    \leavevmode{\fontsize{10}{12}\selectfont\color{muted}\headingfont #1}\par
    \vspace{3mm}%
    \global\cvafterheadingtrue
}

\newcommand\cventrytitle[1]{%
    \leavevmode{\fontsize{8.5}{11}\selectfont\color{strong}\entryfont #1}%
}

% small grey "opens elsewhere" marker after linked titles
\newcommand\cvlinkicon{\hspace{0.4em}{\fontsize{6.5}{6.5}\selectfont\color{muted}\faIcon{external-link-alt}}}

% \cvlinkedtitle{url}{title}: entry title; when url is non-empty, the title and a link icon are clickable
\newcommand\cvlinkedtitle[2]{%
    \if\relax\detokenize{#1}\relax\cventrytitle{#2}\else\href{#1}{\cventrytitle{#2}\cvlinkicon}\fi
}

\newcommand\cvmeta[1]{{\metasize\color{muted}#1\par}}

\newcommand\cvsep{\hspace{0.5em}{\color{hairline}|}\hspace{0.5em}}

% 2. sidebar entry: \cvsideentry[link]{title}{line}{meta}
\newcommand\cvsideentry[4][]{%
    \cventrygap\cventryskip
    \cvlinkedtitle{#1}{#2}\par
    \if\relax\detokenize{#3}\relax\else #3\par\fi
    \cvmeta{#4}%
}

% 3. skill group: \cvskillgroup{label}{items separated by \par}
\newcommand\cvskillgroup[2]{%
    \cventrygap\cventryskip
    \cventrytitle{#1}\par
    #2\par
}

% sidebar paragraph, spaced like the other sidebar entries (used for interests)
\newcommand\cvsideparagraph[1]{%
    \cventrygap\cventryskip
    #1\par
}

% 6. timeline dot, centred on the divider and level with the entry title
\newcommand\cvtimelinedot{%
    \llap{\tikz[baseline=-0.36em]\fill[dot] (0,0) circle (\cvdotradius);%
        \hspace{\dimexpr0.5\cvgap-\cvdotradius\relax}}%
}

% \cv@entry{marker}{link}{title}{meta}: shared by job and project entries
\newcommand\cv@entry[4]{%
    \cventrygap\cvjobskip
    \leavevmode#1%
    \cvlinkedtitle{#2}{#3}\par
    \cvmeta{#4}%
}

% 5. job entry: \cvjob[link]{title}{meta}, with a timeline dot; optionally followed by cvbullets
\newcommand\cvjob[3][]{\cv@entry{\cvtimelinedot}{#1}{#2}{#3}}

% project entry: \cvproject[link]{title}{meta}, like a job entry but without the timeline dot
\newcommand\cvproject[3][]{\cv@entry{}{#1}{#2}{#3}}

% one-line role summary between the job meta line and its bullets
\newcommand\cvjobsummary[1]{%
    \par\vspace{1.5pt}#1\par
}

\newenvironment{cvbullets}{%
    \begin{itemize}[
        leftmargin = 9pt,
        label      = {\color{muted}\textbullet},
        itemsep    = 1.5pt,
        parsep     = 0pt,
        topsep     = 2pt,
        partopsep  = 0pt]
}{%
    \end{itemize}
}
