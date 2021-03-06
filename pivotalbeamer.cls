\ProvidesClass{pivotalbeamer}

% Beamer
\LoadClass[xcolor=dvipsnames,natural,svgnames,rgb,cmyk,table,x11names,aspectratio=169]{beamer}

% language options
\DeclareOption{english}{\input{english}}
\DeclareOption{german}{\input{german}}
\ProcessOptions\relax

% specify theme
\usetheme{default}
\usecolortheme{beaver}
\useinnertheme{circles}
% \usefonttheme[onlymath]{serif}
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{footline}[]

\setbeamercolor{title}{fg=pivotalorange,bg=black}
\setbeamercolor{subtitle}{fg=pivotalorange,bg=black}
\setbeamercolor{author}{fg=pivotalgreen}
\setbeamercolor{date}{fg=pivotalgreen}
% include Pivotal logo on titlepage
\makeatletter
\defbeamertemplate*{title page}{mydefault}[1][]
{
  \vbox{}
  \vfill
  \begin{centering}
    {\usebeamercolor[fg]{titlegraphic}\inserttitlegraphic\par\vskip2em}
    \begin{beamercolorbox}[sep=8pt,center,#1]{title}
      \usebeamerfont{title}\inserttitle\par%
      \ifx\insertsubtitle\@empty%
      \else%
      \vskip0.25em%
      {\usebeamerfont{subtitle}\usebeamercolor[fg]{subtitle}\insertsubtitle\par}%
      \fi%
    \end{beamercolorbox}%
    \vskip1em\par
    \begin{beamercolorbox}[sep=8pt,center,#1]{author}
      \usebeamerfont{author}\insertauthor
    \end{beamercolorbox}
    \begin{beamercolorbox}[sep=8pt,center,#1]{institute}
      \usebeamerfont{institute}\insertinstitute
    \end{beamercolorbox}
    \begin{beamercolorbox}[sep=8pt,center,#1]{date}
      \usebeamerfont{date}\insertdate
    \end{beamercolorbox}\vskip0.5em
  \end{centering}
  \vfill
  }
\setbeamertemplate{title page}[mydefault][colsep=-4bp]
\makeatother
\titlegraphic{\includegraphics[width=10.8cm]{logowhite}}

% remove footline from titlepage
\makeatletter
\def\maketitle{{\setbeamercolor{background canvas}{bg=black}\setbeamertemplate{footline}{}\ifbeamer@inframe\titlepage\else\frame{\titlepage}\fi}}
\makeatother

\setbeamercolor{footlinecolor}{fg=white,bg=pivotalgreen}

\setbeamertemplate{footline}{%
  \begin{beamercolorbox}[sep=1em,wd=\paperwidth,leftskip=0.5cm,rightskip=0.5cm]{footlinecolor}
    % \hspace{0.1cm}%
    \scriptsize{\scriptsize{\insertframenumber}}
    \hfill \vspace{-1mm}\includegraphics[height=10pt]{logowhite}
  \end{beamercolorbox}%
}


% Add Pivotal logo to frame titles
% \addtobeamertemplate{frametitle}{}{%
% \begin{tikzpicture}[remember picture,overlay]
%   \node[anchor=north east,yshift=-2.1pt] at (current page.north east) {\includegraphics[height=0.5cm]{logo}};
%     %   \node[anchor=north east] at (current page.north east) {\includegraphics[height=0.5cm]{logo}};
% \end{tikzpicture}}

% Custom section pages

\AtBeginSection[] % Do nothing for \section*
{
  \bgroup
  \setbeamercolor{background canvas}{bg=black}
  \begin{frame}[plain]{}
    \vfill
    \Huge{\textcolor{pivotalgreen}{\insertsectionhead}}
    \vfill
  \end{frame}
  \egroup
}

% Possibility to adjust margins for figures
\usepackage{geometry}
\usepackage{changepage}
\newenvironment{changemargin}[2]{%
  \begin{list}{}{%
      \setlength{\topsep}{0pt}%
      \setlength{\leftmargin}{#1}%
      \setlength{\rightmargin}{#2}%
      \setlength{\listparindent}{\parindent}%
      \setlength{\itemindent}{\parindent}%
      \setlength{\parsep}{\parskip}%
    }%
  \item[]}{\end{list}}

% load language specific packages
\input{language}

% math packages
\input{math}

% lualatex encoding
\input{encoding}

% colour
% \usepackage[natural, svgnames, rgb, cmyk, table, x11names]{xcolor}
\input{colour}

% other packages
\input{packages}

% bibliography files
% \input{bibliography}

% hyperlinks
\usepackage{url}

% fonts
\defaultfontfeatures{Ligatures=TeX}
% \setmainfont{Helvetica Neue Light}
% \setromanfont{Cambria}
\setsansfont[BoldFont={Helvetica Neue},
 BoldItalicFont={Helvetica Neue Italic},
 ItalicFont={Helvetica Neue Light Italic}]{Helvetica Neue Light}
\setmonofont[Scale=MatchLowercase]{Menlo}
% \setmathfont{TeX Gyre Heros}

% Import all texMacros
%\input{texMacros}

% Adjust beamer theme
\usepackage[labelfont={color=pivotalgreen}]{caption}
\setbeamercolor{frametitle}{fg=pivotalgreen}
\setbeamercolor*{item}{fg=pivotalgreen}
% \setbeamercolor{author}{fg=msdarkblue}
% \setbeamercolor{date}{fg=msdarkblue}

% Fits the presentation to the window when first displayed
\hypersetup{pdfstartview={Fit}}

% Auto resize images that are too large
\usepackage[Export]{adjustbox}
\adjustboxset{max size={\textwidth}{0.7\textheight}}

% fix beamer appendix
\makeatletter
\let\appendixtotalframenumber\empty
\def\mainend{-1}
\let\appendixorig\appendix

\def\appendix{
  \edef\mainend{\theframenumber}
  \immediate\write\@auxout{\string\global\string\@namedef{mainendframenumber}{\mainend}}
  \appendixorig
  \def\inserttotalframenumber{\appendixtotalframenumber}%
  \setcounter{framenumber}{0}
}

\def\pageatend{
  \edef\appendixend{\theframenumber}
  \ifnum\mainend>0%
  \immediate\write\@auxout{\string\global\string\@namedef{appendixtotalframenumber}{\appendixend}}%
  \immediate\write\@auxout{\string\global\string\@namedef{inserttotalframenumber}{\mainend}}%
  \immediate\write\@auxout{\string\@writefile{nav}{\noexpand \headcommand {%
        \noexpand \def\noexpand \inserttotalframenumber{\mainend}}}}%
  \immediate\write\@auxout{\string\@writefile{nav}{\noexpand \headcommand {%
        \noexpand \def\noexpand \appendixtotalframenumber{\appendixend}}}}%
  \else
  \fi
}

\AtEndDocument{\pageatend}
\makeatother