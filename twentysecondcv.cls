\ProvidesClass{twentysecondcv}[2017/01/08 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%	 REQUIRED PACKAGES

\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%	 COLOURS

\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{maingray}{HTML}{B9B9B9}

%	 MISC CONFIGURATIONS

\pagestyle{empty} % Disable headers and footers

\setlength{\parindent}{0pt} % Disable paragraph indentation

%	 SIDEBAR DEFINITIONS

\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength} % Define a new length to hold the remaining line width after the section title is printed
\newlength{\SectionTitleLength} % Define a new length to hold the width of the section title
\newcommand{\profilesection}[1]{%
	\setlength\TotalSectionLength{\linewidth}% Set the total line width
	\settowidth{\SectionTitleLength}{\huge #1 }% Calculate the width of the section title
	\addtolength\TotalSectionLength{-\SectionTitleLength}% Subtract the section title width from the total width
	\addtolength\TotalSectionLength{-2.22221pt}% Modifier to remove overfull box warning
	\vspace{8pt}% Whitespace before the section title
	{\color{black!80} \huge #1 \rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}% Print the title and auto-width rule
}

% Define custom commands for CV info
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}

\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\SidebarSections}[1]{\renewcommand{\SidebarSections}{#1}}


\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvextra}[1]{\renewcommand{\cvextra}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

% Command for printing the contact information icons
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt, fill=mainblue,mainblue,text=white] (char) {#1};}}

% Command for printing skill progress bars


% Command for printing skills text
\newcommand\skillstext[1]{ 
	\renewcommand{\skillstext}{
		\begin{flushleft}
			\foreach [count=\i] \x/\y in {#1}{ 
				\x$ \star $\y
			}
		\end{flushleft}
	}
}

%	 SIDEBAR LAYOUT

\newcommand{\makeprofile}{
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
  \end{tikzpicture}

  \begin{textblock}{6}(0.5, 0.2)
			
    {
    \begin{center}
      \huge\round{\color{white}\cvname}{mainblue}
    \end{center}
    }

    \renewcommand{\arraystretch}{1.5}
    \begin{tabular}{p{0.5cm} @{\hskip 0.5cm}p{5cm}}
      \ifthenelse{\equal{\cvdate}{}}{}{\textsc{\Large\icon{\Info}} & \cvdate\\}
      \ifthenelse{\equal{\cvnumberphone}{}}{}{\textsc{\Large\icon{\Telefon}} & \cvnumberphone\\}
      \ifthenelse{\equal{\cvsite}{}}{}{\textsc{\Large\icon{\Mundus}} & \href{http://\cvsite}{\cvsite}\\}
      \ifthenelse{\equal{\cvmail}{}}{}{\textsc{\large\icon{@}} & \href{mailto:\cvmail}{\cvmail}}
    \end{tabular}
    \cvextra

    \SidebarSections
  \end{textblock}
}

%	 COLOURED SECTION TITLE BOX

% Command to create the rounded boxes around the first three letters of section titles
\newcommand*\round[2]{%
	\tikz[baseline=(char.base)]\node[anchor=center, draw,rectangle, rounded corners, inner sep=3pt, minimum size=6mm, text height=0.7*\f@size, fill=#2,#2,text=white](char){#1};%
}

\renewcommand{\section}[1]{{\Large\round{#1}{mainblue}}}

\renewcommand{\subsection}[1]{
	\par\vspace{.5\parskip}{%
		\large\color{gray} #1%
	}
	\par\vspace{.25\parskip}%
}

%	 LONG LIST ENVIRONMENT

% New environment for the long list
\newenvironment{twenty}{%
\rowcolors{1}{gray!15}{white}
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{
	\end{tabular*}
}

\newcommand{\twentyitem}[4]{%
	\parbox[t]{0.07\textwidth}{\textbf{#1}}&\parbox[t]{0.90\textwidth}{%
		\large{\textbf{#2}}
		\hfill%
		{\textbf{\large#3}}\\%
		{#4}\vspace{\parsep}%
	}\\
}

%	 SMALL LIST ENVIRONMENT


% New environment for the small list
\newenvironment{twentyshort}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newcommand{\twentyitemshort}[2]{%
	#1&\parbox[t]{0.83\textwidth}{%
		\textbf{#2}%
	}\\
}

%	 MARGINS AND LINKS

\RequirePackage[left=7.6cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry}

\RequirePackage{hyperref}
