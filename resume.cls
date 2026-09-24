%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Medium Length Professional CV - RESUME CLASS FILE
%
% This template has been downloaded from:
% http://www.LaTeXTemplates.com
%
% This class file defines the structure and design of the template. 
%
% Original header:
% Copyright (C) 2010 by Trey Hunner
%
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty provided the copyright
% notice and this notice are preserved. This file is offered as-is,
% without any warranty.
%
% Created by Trey Hunner and modified by www.LaTeXTemplates.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{resume}[2010/07/10 v0.9 Resume class]

\LoadClass[12pt,letterpaper]{article} % Font size and paper type

\usepackage[T1]{fontenc} % Proper output of accented characters
\usepackage{newtxtext,newtxmath} % Times font for text and math

\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen} % Required for ifthenelse statements

\pagestyle{empty} % Suppress page numbers

\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default

\def \subtitle#1{\def\@subtitle{#1}} % Defines the \subtitle command to set a line under the name, e.g. the job role
\def \@subtitle {} % Sets \@subtitle to empty by default

% \printname is used to print the name (and the subtitle, if set) as a page header
\def \printname {
	\begingroup
	\centering
	{\namesize\bf \MakeUppercase{\@name}\par}
	\ifx\@subtitle\@empty\else
		\subtitleskip
		{\subtitlesize \@subtitle\par}
	\fi
	\endgroup
}

%----------------------------------------------------------------------------------------
%	CONTACT INFORMATION
%----------------------------------------------------------------------------------------

\RequirePackage[hidelinks]{hyperref} % Clickable email, GitHub and LinkedIn links

% Each command stores one piece of contact information; unset ones are skipped when printing
\def \location#1{\def\@location{#1}} % e.g. \location{Madrid, Spain}
\def \phone#1{\def\@phone{#1}} % e.g. \phone{+34 600 000 000}
\def \email#1{\def\@email{#1}} % e.g. \email{me@example.com}
\def \github#1{\def\@github{#1}} % GitHub username, e.g. \github{P4Bs}
\def \linkedin#1{\def\@linkedin{#1}} % LinkedIn profile id, e.g. \linkedin{john-doe}
\def \@location {}
\def \@phone {}
\def \@email {}
\def \@github {}
\def \@linkedin {}

% Separator shared by the contact line and skill lists (lines may break after the bar, never before it)
\def \itemseparator {\nobreak\ $\vert$\ }

% Prints the separator before every item except the first one
\newif\if@contactsep
\def \@contactitem#1{\if@contactsep\itemseparator\fi#1\@contactseptrue}

% \skilllist prints a comma-separated list of items joined by the separator, e.g. \skilllist{C, Python, Rust}
\def \skilllist#1{%
	\begingroup
	\raggedright % Break lines before the margin instead of justifying; the fixed separator spacing cannot stretch
	\setlength{\baselineskip}{\skilllinespread\baselineskip}%
	\def\itemseparator{\nobreak\hspace{\skillsepspace}$\vert$\hspace{\skillsepspace}}%
	\@contactsepfalse
	\@for\@skill:=#1\do{\@contactitem{\mbox{\ignorespaces\@skill}}}% \mbox keeps multi-word skills on one line
	\par % End the paragraph inside the group so the line spacing applies
	\endgroup
}

% \printcontact prints all the contact information set above, centered and separated by vertical bars
\def \printcontact {
	\begingroup
	\@contactsepfalse
	\centering
	\ifx\@location\@empty\else\@contactitem{\@location}\fi
	\ifx\@email\@empty\else\@contactitem{\href{mailto:\@email}{\@email}}\fi
	\ifx\@phone\@empty\else\@contactitem{\@phone}\fi
	\ifx\@github\@empty\else\@contactitem{\href{https://github.com/\@github}{GitHub Profile}}\fi
	\ifx\@linkedin\@empty\else\@contactitem{\href{https://www.linkedin.com/in/\@linkedin}{LinkedIn Profile}}\fi
	\par
	\endgroup
}


%----------------------------------------------------------------------------------------
%	SECTION FORMATTING
%----------------------------------------------------------------------------------------

% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
	\sectionskip
	\MakeUppercase{\bf #1} % Section title
	\sectionlineskip
	\hrule % Horizontal line
	\begin{list}{}{ % List for each individual item in the section
			\setlength{\leftmargin}{1.5em} % Margin within the section
		}
		\item[]
	}{
	\end{list}
}

%----------------------------------------------------------------------------------------
%	WORK EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

% The bullet list is only opened by the first \item, so the content can be empty,
% plain paragraphs, bullet points, or paragraphs followed by bullet points
\newif\if@rsublist % True once the first \item has opened the bullet list
\let\@rsuborigitem\item % Keep LaTeX's own \item to restore it when the list opens

% Replaces \item until the first bullet: opens the list, then behaves like a normal \item
\def\@rsubfirstitem{%
	\@rsublisttrue
	\let\item\@rsuborigitem
	\begin{list}{$\cdot$}{\leftmargin=0em} % \cdot used for bullets, no indentation
		\itemsep -0.5em \vspace{-0.5em} % Compress items in list together for aesthetics
		\item
}

\newenvironment{rSubsection}[4]{ % 4 input arguments - company name, year(s) employed, job title and location
	{\bf #1} \hfill {#2} % Bold company name and date on the right
	\ifthenelse{\equal{#3}{}}{}{ % If the third argument is not specified, don't print the job title and location line
		\\
		{\em #3} \hfill {\em #4} % Italic job title and location
	}\smallskip\par
	\@rsublistfalse
	\let\item\@rsubfirstitem
	\ignorespaces
	}{
	\if@rsublist\end{list}\else\par\fi
	\vspace{0.5em} % Some space after the list of bullet points
}

% The below commands define the whitespace after certain things in the document - they can be \smallskip, \medskip or \bigskip
\def\namesize{\huge} % Size of the name at the top of the document
\def\subtitlesize{\Large} % Size of the subtitle under the name
\def\subtitleskip{\vspace{-0.5em}} % The space between the name and the subtitle
\def\skilllinespread{1.25} % Line spacing of the skill list, relative to normal text
\def\skillsepspace{0.5em} % The space on each side of the separator in the skill list
\def\addressskip{\smallskip} % The space between the two address (or phone/email) lines
\def\sectionlineskip{\medskip} % The space above the horizontal line for each section 
\def\nameskip{\bigskip} % The space after your name at the top
\def\sectionskip{\medskip} % The space after the heading section
