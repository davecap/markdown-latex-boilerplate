%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%%  UT-THESIS.CLS (v1.8)
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory CTAN:/macros/latex/base/lppl.txt.
%%
%%  Copyright (c) 1999 by Francois Pitt
%%  Last Update: 1999 December 10
%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\utthesisversion}{v1.8} % current version number
\newcommand{\utthesisupdated}{1999/12/10} % date of last change(s)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%%  This file is distributed in the hope that it will be useful but
%%  without any warranty (without even the implied warranty of
%%  fitness for a particular purpose).  For a description of this
%%  file's purpose, and instructions on its use, see below.
%%  
%%  Feel free to copy and redistribute this file, as long as this
%%  copyright notice remains intact.  You may also modify the file
%%  to suit your particular needs, as long as you indicate your
%%  changes below (and inform the original author of your changes:
%%  he's always curious to know what people think of his work).
%%  
%%  Send all bugs, questions, comments, suggestions, etc. to the
%%  author, at <fpitt@cs.utoronto.ca>.
%%  
%%  KNOWN BUGS: (reported by Robert Bernecky)
%%  
%%   - [On missing page headers for float pages.]
%%     `teTex' under Linux fails in precisely the same way as does
%%     `MikTeX', so there's something clearly wrong somewhere, but
%%     I don't know where.  It only fails on odd-numbered pages (if
%%     you remove enough text so that the page floats back to an
%%     even-numbered page, the page header is correct)!
%%   - [On `dedication' and `acknowledgements' causing an error when
%%      they both appear on the same page.]
%%     `teTeX' and `MikTeX' both fail the same way on this one, with
%%     "LaTeX error: Something's wrong--perhaps a missing \item".
%%     Adding a \newpage between the two environments "fixes" the
%%     problem.  Unsure what causes this, but it could be a bug
%%     common to all x86 platforms...
%%  
%%  REVISION HISTORY:
%%  
%%  v1.8: 1999/12/10 (Francois Pitt)
%%      - Fixed circular definition problem with \currenttextsize
%%        that caused TeX to run out of input stack memory.
%%  v1.7: 1999/06/02,1999/05/20,1999/05/13 (Francois Pitt)
%%      - Minor change to the format of the date printed on every
%%        page with the `draft' option.
%%      - Minor cosmetic change to the word "DRAFT" printed on the
%%        corners of every page with the `draft' option.
%%      - Made `draft' mode doublespaced by default (it just makes
%%        more sense for actual drafts; suggested by Eric Joanis).
%%      - Changed \currenttextsize from a "\newcommand" to a "\let".
%%      - Added "known bugs" above.
%%  v1.6: 1999/03/06 (Francois Pitt)
%%      - Minor change: replaced ``\ifx\empty#1\else...\fi'' with
%%        ``\ifx\empty#1\empty\else...\fi'' (the former works only
%%        by accident while the latter is logically correct).
%%  v1.5: 1999/02/17 (Francois Pitt)
%%      - Fixed missing page numbers and headers by removing
%%        redefinition of \cleardoublepage (reported by Robert
%%        Bernecky 1999/02/04 and Nedialko Nedialkov 1999/02/12).
%%      - Added \clearemptydoublepage and \clearplaindoublepage
%%        commands.
%%      - Removed redefinitions of \tableofcontents, \listoftables,
%%        and \listoffigures because they already call \clearpage
%%        or \cleardoublepage by default.
%%      - Removed "\setcounter{tocdepth}{2}" from the page layout
%%        section (moved to `ut-thesis.tex' where it belongs).
%%      - Added \ignore command to comment out parts of a file.
%%      - Put version macros at the top of the file.
%%      - Changed order of revision comments.
%%  v1.4: 1998/11/05 (Francois Pitt)
%%      - Fixed `abstract' environment so that it is really put on a
%%        separate page, and changed "\newpage\endgroup" at the end
%%        to "\par\endgroup\newpage", which is more logical.
%%      - Changed `acknowledgements' environment so that it is *not*
%%        put on a separate page, allowing users to add other text
%%        on that page (e.g., `dedication' described next).
%%      - Added `dedication' environment based on `acknowledgements'
%%        (suggested by Robert Bernecky 98/11/04).
%%      - Changed page layout so that it is defined in terms of the
%%        physical page size instead of being hard-coded for letter
%%        paper (8.5" x 11").
%%  v1.3: 1998/11/01 (Francois Pitt)
%%      - Fixed `thebibliography' so page headers are generated in
%%        the same style as for the rest of the thesis.
%%      - Swapped \endgroup and \newpage in definition of `abstract'
%%        and `acknowledgements' environments, to fix problem with
%%        adjusted line spacing in `abstract'.
%%      - Renamed `\currentsize' to `\currenttextsize'.
%%      - Added \cleardoublepage at the end of preliminary sections,
%%        so that page 1 of main text is on right-hand side.
%%  v1.2: 1998/10/20 (Francois Pitt)
%%      - Changed `spacenotes' option to `spacednotes' to have more
%%        consistently named options.
%%      - Fixed spacing between main text and footnotes.
%%      - Fixed `singlespaced' environment, which didn't seem to
%%        work at all (reported by Nedialko Nedialkov 98/10/12):
%%        Actually, created a `newspacing' environment, which takes
%%        a parameter, and based `singlespaced', `oneandahalfspaced',
%%        and `doublespaced' environments on `newspacing'.
%%  v1.1: 1998/10/01 (Francois Pitt)
%%      - Fixed bug that caused footnotes to make following tables
%%        single-spaced (reported by Philip Edmonds 98/09/30).
%%      - Made spacing of marginal notes and footnotes the same.
%%      - Added option to control line spacing of notes.
%%      - Added options to control the size of margins.
%%      - Changed names of temporary macros used in redefinitions
%%        to avoid conflicts with existing names.
%%  v1.0: 1998/09/29 (Francois Pitt)
%%      - Initial version.
%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  
%%  LaTeX2e class file for formatting documents according to the
%%  School of Graduate Studies' guidelines for theses at the
%%  University of Toronto (conforms to SGS guidelines of 07/97). 
%%  
%%  USAGE:  \documentclass{ut-thesis}
%%          \documentclass[...options...]{ut-thesis}
%%  
%%  The default settings produce a final copy, ready for submission
%%  to SGS (12pt font, single-sided, double-spaced, normal margins,
%%  with single-spaced notes).
%%  
%%  OPTIONS:
%%  
%%   - Any standard option for the LaTeX2e `report' class, including
%%     `10pt', `11pt', `12pt', `oneside', `twoside', etc.
%%  
%%   - `singlespaced', `oneandahalfspaced', or `doublespaced':  Set
%%     the entire document's default line spacing, except for notes,
%%     which are single-spaced by default.
%%  
%%   - `spacednotes':  Let the line spacing of notes be determined
%%     by the line spacing of the main document, instead of being
%%     forced single-spaced.
%%  
%%   - `narrowmargins', `normalmargins', `widemargins', or
%%     `extrawidemargins':  Set the size of the margins, as follows:
%%      . `narrow': 1 1/4" on the left, 3/4" on all other sides,
%%        headers & footers 1/4" from body;
%%      . `normal': 1 1/4" on the left, 1" on all other sides,
%%        headers & footers 1/2" from body;
%%      . `wide': 1 1/4" on all sides, headers & footers 3/4" from
%%        body;
%%      . `extrawide': 1 1/2" on all sides, headers & footers 3/4"
%%        from body.
%%     (If you have more than just a few marginal notes, it is
%%     recommended that you use `wide' or `extrawide' margins.)
%%  
%%   - `draft':  Produce a draft copy (10pt font, double-sided,
%%     double-spaced, normal margins, with the word "DRAFT" printed
%%     at all four corners of every page).
%%  
%%  Note that these options can be used to override the default or
%%  draft document settings, so that it is possible, for example,
%%  to create a double-sided final copy, or a 1 1/2-spaced draft
%%  copy with wide margins, etc.  Also note that when producing
%%  double-sided documents, new chapters and preliminary sections
%%  will always start on a right-hand page under the default
%%  settings (inserting a blank page if needed), but not if the
%%  `draft' option was used.  (This can be overriden by using the
%%  `openany' or `openright' options.  To achieve this effect for
%%  individual sections or chapters, use the \cleardoublepage
%%  command.)  Note that the blank page inserted in these cases will
%%  still contain the header and page number that is present on all
%%  pages.  For `empty' or `plain' pages, explicitly use one of the
%%  commands \clearemptydoublepage or \clearplaindoublepage.
%%  
%%  NEW ENVIRONMENTS and COMMANDS:
%%  
%%   * \degree{...}:  (preamble only; REQUIRED)
%%     Specify the name of the degree (e.g., "Doctor of Philosophy").
%%  
%%   * \department{...}:  (preamble only; REQUIRED)
%%     Specify the name of the graduate department.
%%  
%%   * \gradyear{...}:  (preamble only; REQUIRED)
%%     Specify the year of graduation (defaults to current year).
%%  
%%   * \author{...}:  (preamble only; REQUIRED)
%%     Specify the name of the author.
%%  
%%   * \title{...}:  (preamble only; REQUIRED)
%%     Specify the title of the thesis.
%%  
%%   - \linespacing{...}:  (preamble only)
%%     Set the interline spacing directly, overriding document
%%     defaults and options; note that in order to get the correct
%%     appearance, the argument to \linespacing must be equal to
%%     1/3 + 2/3 times the desired line spacing (for example,
%%        single-spaced = \linespacing{1},
%%         1 1/2-spaced = \linespacing{1.33}, and
%%        double-spaced = \linespacing{1.66}).
%%  
%%   - \ignore{...}:
%%     Ignore the part of the file between { and } (can include
%%     paragraph breaks); useful for commenting out large blocks.
%%  
%%   - \clearemptydoublepage, \clearplaindoublepage:
%%     Same as \cleardoublepage except that it sets the pagestyle of
%%     any inserted blank page to `empty' or `plain', respectively.
%%  
%%   - \begin{preliminary}...\end{preliminary}:
%%     Delimit head matter (title page, abstract, table of contents,
%%     lists of tables and figures, etc.): set the page style and
%%     numbering for the preliminary sections and reset them for the
%%     main document.
%%  
%%      - \maketitle:
%%        Generate the title page from the information supplied
%%        in the preamble.
%%  
%%      - \begin{abstract}...\end{abstract}:
%%        Generate the abstract page.  (According to SGS guidelines,
%%        this must immediately follow the title page.)
%%  
%%      - \begin{dedication}...\end{dedication}:
%%        Generate a dedication section, if needed.
%%  
%%      - \begin{acknowledgements}...\end{acknowledgements}:
%%        Generate an acknowledgements section, if needed.
%%  
%%     Note that neither the `dedication' nor the `acknowledgements'
%%     are put on a separate page by default (use \newpage to do
%%     this explicitly).  Also note that the table of contents, list
%%     of tables, and list of figures can be generated using the
%%     usual LaTeX commands.
%%  
%%   - \begin{longquote}...\end{longquote}:
%%     Single-spaced version of the `quote' environment.
%%  
%%   - \begin{longquotation}...\end{longquotation}:
%%     Single-spaced version of the `quotation' environment.
%%  
%%   - \begin{singlespaced}...\end{singlespaced}:
%%     Format single-spaced paragraphs.
%%  
%%   - \begin{oneandahalfspaced}...\end{oneandahalfspaced}:
%%     Format 1 1/2-spaced paragraphs.
%%  
%%   - \begin{doublespaced}...\end{doublespaced}:
%%     Format double-spaced paragraphs.
%%  
%%   - \begin{newspacing}{<n>}...\end{newspacing}:
%%     Format paragraphs with an interline spacing of `n'.
%%  
%%  (Note that the last four environments can be used to change the
%%  default line spacing of any enclosed text, including figures,
%%  tables, abstract or acknowledgement pages, table of contents,
%%  etc.)
%%  
%%  The companion file `ut-thesis.tex' contains a skeleton
%%  illustrating the use of this class.
%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%        IDENTIFICATION        %%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ut-thesis}%
 [\utthesisupdated\space\utthesisversion\space LaTeX2e document class]


%%%%%%%%%%%%         INITIAL CODE         %%%%%%%%%%%%

%% To comment out parts of a file.
%% >> Added in v1.5 on 1999/02/17 by Francois Pitt. << %%
%
\newcommand{\ignore}[1]{}

%% Switch for testing draft mode (toggled by `draft' option).
%
\newif\if@draft
\@draftfalse % initially false by default

%% Switch for testing current page style.
%% >> Added in v1.3 on 1998/11/01 by Francois Pitt. << %%
%
\newif\if@thesispage
 % no default value (set by \pagestyle)

%% Switch for testing line spacing of notes.
%% >> Added in v1.1 on 1998/10/01 by Francois Pitt. << %%
%
\newif\if@singlespacednotes
\@singlespacednotestrue % initially true by default

%% Macro for testing the size of margins.
%% >> Added in v1.1 on 1998/10/01 by Francois Pitt. << %%
%
\newcommand{\@marginsize}{}

%% Because of the draft option, and to allow users to override
%% defaults, we don't want to be passing conflicting options back to
%% the report class, so we define our own temporary toggles holding
%% the most recent setting for each of four basic options: point size,
%% number of page sides, whether new chapters open on right-hand pages
%% or on any page, and line spacing.  These toggles will be set from
%% the corresponding options below.
%
\newcommand{\@thesisptsz}{}
\newcommand{\@thesisside}{}
\newcommand{\@thesisopen}{}
\newcommand{\@thesislnsp}{}


%%%%%%%%%%%%      OPTION DECLARATION      %%%%%%%%%%%%

%% `draft' option: change default document settings.
%% >> Changed in v1.1 on 1998/10/01 by Francois Pitt. << %%
%% >> Changed in v1.7 on 1999/05/20 by Francois Pitt. << %%
%
\DeclareOption{draft}{\@drafttrue
   \typeout{UT-Thesis Class Option: `draft'}
   \ExecuteOptions{10pt,twoside,openany,doublespaced,normalmargins}
   \PassOptionsToClass{draft}{report}
   %% Macros for printing "DRAFT" at the corners of a page.
   \newcommand{\tlDRAFT}%
     {\raisebox{ 3ex}[0pt][0pt]{\llap{\sffamily\scriptsize DRAFT\ \ }}}
   \newcommand{\trDRAFT}%
     {\raisebox{ 3ex}[0pt][0pt]{\rlap{\sffamily\scriptsize \ \ DRAFT}}}
   \newcommand{\blDRAFT}%
     {\raisebox{-3ex}[0pt][0pt]{\llap{\sffamily\scriptsize DRAFT\ \ }}}
   \newcommand{\brDRAFT}%
     {\raisebox{-3ex}[0pt][0pt]{\rlap{\sffamily\scriptsize \ \ DRAFT}}}
}%DeclareOption{draft}

%% `spacednotes' option: make notes share the line spacing of the rest
%% of the document.
%% >> Added in v1.1 on 1998/10/01 by Francois Pitt. << %%
%% >> Changed in v1.2 on 1998/10/20 by Francois Pitt. << %%
%
\DeclareOption{spacednotes}{\@singlespacednotesfalse}

%% Margin options: change the size of margins.
%% >> Added in v1.1 on 1998/10/01 by Francois Pitt. << %%
%
\DeclareOption{narrowmargins}{\renewcommand{\@marginsize}{0}}
\DeclareOption{normalmargins}{\renewcommand{\@marginsize}{1}}
\DeclareOption{widemargins}{\renewcommand{\@marginsize}{2}}
\DeclareOption{extrawidemargins}{\renewcommand{\@marginsize}{3}}

%% Point Size options: change current setting.
%
\DeclareOption{10pt}{\renewcommand{\@thesisptsz}{10pt}}
\DeclareOption{11pt}{\renewcommand{\@thesisptsz}{11pt}}
\DeclareOption{12pt}{\renewcommand{\@thesisptsz}{12pt}}

%% Number of Page Sides options: change current setting.
%
\DeclareOption{twoside}{\renewcommand{\@thesisside}{twoside}}
\DeclareOption{oneside}{\renewcommand{\@thesisside}{oneside}}

%% New Chapter Openings options: change current setting.
%
\DeclareOption{openany}{\renewcommand{\@thesisopen}{openany}}
\DeclareOption{openright}{\renewcommand{\@thesisopen}{openright}}

%% Line Spacing options: change current setting.
%
\DeclareOption{singlespaced}{\renewcommand{\@thesislnsp}{1}}
\DeclareOption{oneandahalfspaced}{\renewcommand{\@thesislnsp}{1.33}}
\DeclareOption{doublespaced}{\renewcommand{\@thesislnsp}{1.66}}

%% All other options are passed to the base class directly.
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}


%%%%%%%%%%%%       OPTION EXECUTION       %%%%%%%%%%%%

%% Default settings.
%% >> Changed in v1.1 on 1998/10/01 by Francois Pitt. << %%
%
\ExecuteOptions{12pt,oneside,openright,doublespaced,normalmargins}
%
%% Process options.
%
\ProcessOptions


%%%%%%%%%%%%       PACKAGE  LOADING       %%%%%%%%%%%%

%% Load base class using current setting for basic options.
%
\LoadClass[\@thesisptsz,\@thesisside,\@thesisopen]{report}


%%%%%%%%%%%%          MAIN  CODE          %%%%%%%%%%%%

%%%%%%    Parameters
%
%% The following five commands set the respective field values so we
%% can generate the title page and abstract page automatically.
%% >> Changed in v1.6 on 1999/03/06 by Francois Pitt. << %%
%
\newcommand{\degree}[1]%
  {\ifx\empty#1\empty\else\gdef\@degree{#1}\fi}
\newcommand{\department}[1]%
  {\ifx\empty#1\empty\else\gdef\@department{#1}\fi}
\newcommand{\gradyear}[1]%
  {\ifx\empty#1\empty\else\gdef\@gradyear{#1}\fi}
\renewcommand{\author}[1]%
  {\ifx\empty#1\empty\else\gdef\@author{#1}\fi}
\renewcommand{\title}[1]%
  {\ifx\empty#1\empty\else\gdef\@title{#1}\fi}

%%%%%%    Line Spacing
%
%% \linespacing is used to define the line spacing.  If the argument
%% is less than 1.33 (for 1.5-spaced) a warning message is displayed
%% when not in draft mode.
%% >> Changed in v1.1 on 1998/10/01 by Francois Pitt. << %%
%
\newcommand{\linespacing}[1]%
  {\newlinestretch{#1}\if@draft\else\ifdim #1pt < 1.33pt\typeout
   {UT-Thesis Class Warning: line spacing less than 1 1/2}\fi\fi}
%
%% `longquote' and `longquotation' produce single-spaced quotes, while
%% `newspacing' encloses paragraphs with a different line spacing,
%% such as `singlespaced', `oneandahalfspaced', or `doublespaced'.
%
\newenvironment{longquote}%
  {\begin{quote}\newlinestretch{1}}{\end{quote}}
\newenvironment{longquotation}%
  {\begin{quotation}\newlinestretch{1}}{\end{quotation}}
%% >> Changed in v1.2 on 1998/10/20 by Francois Pitt. << %%
\newenvironment{singlespaced}%
  {\begin{newspacing}{1}}{\end{newspacing}}
%% >> Added in v1.2 on 1998/10/20 by Francois Pitt. << %%
\newenvironment{oneandahalfspaced}%
  {\begin{newspacing}{1.33}}{\end{newspacing}}
\newenvironment{doublespaced}%
  {\begin{newspacing}{1.66}}{\end{newspacing}}
\newenvironment{newspacing}[1]%
  {\par\begingroup\newlinestretch{#1}}%
  {\par\vskip\parskip\vskip\baselineskip\endgroup
   \vskip-\parskip\vskip-\baselineskip}
%
%% To change the actual line spacing.
%% >> Changed in v1.2 on 1998/10/20 by Francois Pitt. << %%
%% >> Changed in v1.3 on 1998/11/01 by Francois Pitt. << %%
%
\newcommand{\newlinestretch}[1]%
  {\renewcommand{\baselinestretch}{#1}\currenttextsize}
%
%% To keep track of the current text size.
%% >> Added in v1.2 on 1998/10/20 by Francois Pitt. << %%
%% >> Changed in v1.3 on 1998/11/01 by Francois Pitt. << %%
%% >> Changed in v1.7 on 1999/05/13 by Francois Pitt. << %%
%
\let\currenttextsize=\normalsize
%
%% Redefine size-changing commands to update \currenttextsize.
%% >> Added in v1.2 on 1998/10/20 by Francois Pitt. << %%
%% >> Changed in v1.3 on 1998/11/01 by Francois Pitt. << %%
%% >> Changed in v1.7 on 1999/05/13 by Francois Pitt. << %%
%% >> Changed in v1.8 on 1999/12/10 by Francois Pitt. << %%
%
\let\tmp@tiny=\tiny
\renewcommand{\tiny}%
  {\let\currenttextsize=\tmp@tiny\tmp@tiny}
\let\tmp@scriptsize=\scriptsize
\renewcommand{\scriptsize}%
  {\let\currenttextsize=\tmp@scriptsize\tmp@scriptsize}
\let\tmp@footnotesize=\footnotesize
\renewcommand{\footnotesize}%
  {\let\currenttextsize=\tmp@footnotesize\tmp@footnotesize}
\let\tmp@small=\small
\renewcommand{\small}%
  {\let\currenttextsize=\tmp@small\tmp@small}
\let\tmp@normalsize=\normalsize
\renewcommand{\normalsize}%
  {\let\currenttextsize=\tmp@normalsize\tmp@normalsize}
\let\tmp@large=\large
\renewcommand{\large}%
  {\let\currenttextsize=\tmp@large\tmp@large}
\let\tmp@Large=\Large
\renewcommand{\Large}%
  {\let\currenttextsize=\tmp@Large\tmp@Large}
\let\tmp@LARGE=\LARGE
\renewcommand{\LARGE}%
  {\let\currenttextsize=\tmp@LARGE\tmp@LARGE}
\let\tmp@huge=\huge
\renewcommand{\huge}%
  {\let\currenttextsize=\tmp@huge\tmp@huge}
\let\tmp@Huge=\Huge
\renewcommand{\Huge}%
  {\let\currenttextsize=\tmp@Huge\tmp@Huge}
%
%% Make notes single-spaced if `spacednotes' option was not given.
%% Note that this does _not_ change the spacing of figures or tables.
%% >> Changed in v1.1 on 1998/10/01 by Francois Pitt. << %%
%
\if@singlespacednotes
%% Make footnotes single-spaced.
\let\tmp@@footnotetext=\@footnotetext
\renewcommand{\@footnotetext}[1]%
  {{\newlinestretch{1}\tmp@@footnotetext{#1}}}
%% Make footnotes inside a minipage single-spaced.
\let\tmp@@mpfootnotetext=\@mpfootnotetext
\renewcommand{\@mpfootnotetext}[1]%
  {{\newlinestretch{1}\tmp@@mpfootnotetext{#1}}}
%% Make marginal notes single-spaced.
\let\tmp@@marginparreset=\@marginparreset
\renewcommand{\@marginparreset}%
  {\newlinestretch{1}\tmp@@marginparreset}
\fi%@singlespacednotes

%%%%%%    New formatting environments and commands.
%
%% \begin{preliminary} sets the pagestyle and pagenumbering for the
%% preliminary sections; \end{preliminary} resets the pagenumbering.
%% The default page style is used outside of the preliminary block.
%% >> Changed in v1.3 on 1998/11/01 by Francois Pitt. << %%
%
\newenvironment{preliminary}%
  {\pagestyle{plain}\pagenumbering{roman}}%
  {\cleardoublepage\pagenumbering{arabic}}
%
%% Change \maketitle to follow SGS guidelines.
%
\renewcommand{\maketitle}{
   \begingroup
   \newlinestretch{1}
   \begin{titlepage}
   \begin{large}
   \begin{center}
      \mbox{}
      \vfill
      \textsc{\@title}\\
      \vfill
      by \\
      \vfill
      {\@author}\\
      \vfill
      \vfill
      A thesis submitted in conformity with the requirements\\
      for the degree of {\@degree}\\
      Graduate Department of {\@department}\\
      University of Toronto\\
      \vfill
      Copyright {\copyright} {\@gradyear} by {\@author}\\
      \vspace{.2in}
      \mbox{}
   \end{center}
   \end{large}
   \setcounter{page}{1}
   \end{titlepage}
   \endgroup
   \setcounter{page}{2}
}%maketitle
%
%% Change \begin{abstract}...\end{abstract} to follow SGS guidelines
%% and put the abstract on a separate page (checking @openright).
%% >> Changed in v1.4 on 1998/11/05 by Francois Pitt. << %%
%
\renewenvironment{abstract}{
   \if@openright\cleardoublepage\else\clearpage\fi
   \begin{center}
      \section*{Abstract}
   \end{center}
   \begin{center}
      {\@title}\\[2ex]
      {\@author}\\
      {\@degree}\\
      Graduate Department of {\@department}\\
      University of Toronto\\
      {\@gradyear}\\
   \end{center}
   \begingroup
   %% Adjust the line spacing: if it was less than 1 1/2,
   %% increase it to 1 1/2; if it was between 1 1/2 and 2,
   %% increase it to 2; otherwise, leave it as is.
   \ifdim \baselinestretch pt < 1.33pt \newlinestretch{1.33}\else
   \ifdim \baselinestretch pt < 1.66pt \newlinestretch{1.66}\fi\fi
}{\par\endgroup\newpage}%abstract
%
%% \begin{dedication}...\end{dedication} formats a
%% dedication section (*not* on a separate page).
%% >> Added in v1.4 on 1998/11/05 by Francois Pitt. << %%
%
\newenvironment{dedication}%
  {\begin{center}
      \section*{Dedication}
   \end{center}
   \begingroup}%
  {\par\endgroup}
%
%% \begin{acknowledgements}...\end{acknowledgements} formats an
%% acknowledgements section (*not* on a separate page).
%% >> Changed in v1.4 on 1998/11/05 by Francois Pitt. << %%
%
\newenvironment{acknowledgements}%
  {\begin{center}
      \section*{Acknowledgements}
   \end{center}
   \begingroup}%
  {\par\endgroup}
%
%% ...\renewcommand{\tableofcontents}...
%% ...\renewcommand{\listoftables}...
%% ...\renewcommand{\listoffigures}...
%% >> Removed in v1.5 on 1999/02/17 by Francois Pitt. << %%
%
%% Redefine `thebibliography' environment so that it generates
%% headers in the same style as the rest of the document.
%% >> Added in v1.3 on 1998/11/01 by Francois Pitt. << %%
%
\let\tmp@thebibliography=\thebibliography
\renewcommand{\thebibliography}[1]{\tmp@thebibliography{#1}
   \if@thesispage\@mkboth{\textsc{\bibname}}{\textsc{\bibname}}\fi}
%
%% ...\renewcommand{\cleardoublepage}...
%% >> Removed in v1.5 on 1999/02/17 by Francois Pitt. << %%
%
%% Variations of \cleardoublepage that explicitly set the pagestyle
%% of any inserted blank page.
%% >> Added in v1.5 on 1999/02/17 by Francois Pitt. << %%
%
\newcommand{\clearemptydoublepage}%
  {{\pagestyle{empty}\cleardoublepage}}
\newcommand{\clearplaindoublepage}%
  {{\pagestyle{plain}\cleardoublepage}}

%%%%%%    Page Styles
%% >> Changed in v1.3 on 1998/11/01 by Francois Pitt. << %%
%% >> Changed in v1.7 on 1999/06/02 by Francois Pitt. << %%
%
%% Redefine all four standard page styles (empty, plain, headings,
%% myheadings), based on the definitions in `report', so that they
%% conform to the SGS guidelines (and include draft information if
%% applicable).  Then, define a new pagestyle `utthesis' (default).
%
%% Pagestyle `empty'.
%
\renewcommand{\ps@empty}{\@thesispagefalse
   \let\@mkboth\@gobbletwo
   \def\@oddfoot{\if@draft\blDRAFT\hfil
      {\slshape\small\today}\hfil\brDRAFT\fi}%
   \let\@evenfoot\@oddfoot
   \def\@oddhead{\if@draft\tlDRAFT\hfil
      {\slshape\small\today}\hfil\trDRAFT\fi}%
   \let\@evenhead\@oddhead
}%ps@empty
%
%% Pagestyle `plain'.
%
\renewcommand{\ps@plain}{\@thesispagefalse
   \let\@mkboth\@gobbletwo
   \def\@oddfoot{\if@draft\blDRAFT\fi\hfil
      \thepage\hfil\if@draft\brDRAFT\fi}%
   \let\@evenfoot\@oddfoot
   \def\@oddhead{\if@draft\tlDRAFT\hfil
      {\slshape\small\today}\hfil\trDRAFT\fi}%
   \let\@evenhead\@oddhead
}%ps@plain
%
%% Pagestyle `headings'.
%
\if@twoside % if two-sided printing
\renewcommand{\ps@headings}{\@thesispagefalse
   \let\@mkboth\markboth
   \def\@oddfoot{\if@draft\blDRAFT\hfil
      {\slshape\small\today}\hfil\brDRAFT\fi}%
   \let\@evenfoot\@oddfoot
   \def\@oddhead{\if@draft\tlDRAFT\fi{\slshape\rightmark}\hfil
      \thepage\if@draft\trDRAFT\fi}%
   \def\@evenhead{\if@draft\tlDRAFT\fi\thepage\hfil
      {\slshape\leftmark}\if@draft\trDRAFT\fi}%
   \def\chaptermark##1{\markboth
      {\MakeUppercase{\ifnum\c@secnumdepth >\m@ne
         \@chapapp\ \thechapter. \ \fi ##1}}{}}%
   \def\sectionmark##1{\markright
      {\MakeUppercase{\ifnum\c@secnumdepth >\z@
         \thesection. \ \fi ##1}}}%
}%ps@headings
\else % if one-sided printing
\renewcommand{\ps@headings}{\@thesispagefalse
   \let\@mkboth\markboth
   \def\@oddfoot{\if@draft\blDRAFT\hfil
      {\slshape\small\today}\hfil\brDRAFT\fi}%
   \def\@oddhead{\if@draft\tlDRAFT\fi{\slshape\rightmark}\hfil
      \thepage\if@draft\trDRAFT\fi}%
   \def\chaptermark##1{\markright
      {\MakeUppercase{\ifnum\c@secnumdepth >\m@ne
         \@chapapp\ \thechapter. \ \fi ##1}}}%
}%ps@headings
\fi%@twoside
%
%% Pagestyle `myheadings'.
%
\renewcommand{\ps@myheadings}{\@thesispagefalse
   \let\@mkboth\@gobbletwo
   \def\@oddfoot{\if@draft\blDRAFT\hfil
      {\slshape\small\today}\hfil\brDRAFT\fi}%
   \let\@evenfoot\@oddfoot
   \def\@oddhead{\if@draft\tlDRAFT\fi{\slshape\rightmark}\hfil
      \thepage\if@draft\trDRAFT\fi}%
   \def\@evenhead{\if@draft\tlDRAFT\fi\thepage\hfil
      {\slshape\leftmark}\if@draft\trDRAFT\fi}%
   \let\chaptermark\@gobble\let\sectionmark\@gobble
}%ps@myheadings
%
%% Pagestyle `utthesis' (based on `headings').
%
\if@twoside % if two-sided printing
\newcommand{\ps@utthesis}{\@thesispagetrue
   \let\@mkboth\markboth
   \def\@oddfoot{\if@draft\blDRAFT\hfil
      {\slshape\small\today}\hfil\brDRAFT\fi}%
   \let\@evenfoot\@oddfoot
   \def\@oddhead{\if@draft\tlDRAFT\fi{\slshape\rightmark}\hfil
      \thepage\if@draft\trDRAFT\fi}%
   \def\@evenhead{\if@draft\tlDRAFT\fi\thepage\hfil
      {\slshape\leftmark}\if@draft\trDRAFT\fi}%
   \def\chaptermark##1{\markboth
      {\textsc{\ifnum\c@secnumdepth >\m@ne
         \@chapapp\ \thechapter. \ \fi ##1}}{}}%
   \def\sectionmark##1{\markright
      {\textsc{\ifnum\c@secnumdepth >\z@
         \thesection. \ \fi ##1}}}%
}%ps@utthesis
\else % if one-sided printing
\newcommand{\ps@utthesis}{\@thesispagetrue
   \let\@mkboth\markboth
   \def\@oddfoot{\if@draft\blDRAFT\hfil
      {\slshape\small\today}\hfil\brDRAFT\fi}%
   \def\@oddhead{\if@draft\tlDRAFT\fi{\slshape\rightmark}\hfil
      \thepage\if@draft\trDRAFT\fi}%
   \def\chaptermark##1{\markright
      {\textsc{\ifnum\c@secnumdepth >\m@ne
         \@chapapp\ \thechapter. \ \fi ##1}}}%
}%ps@utthesis
\fi%@twoside

%%%%%%    Document Layout
%% >> Changed in v1.5 on 1999/02/17 by Francois Pitt. << %%
%
%% Default line spacing: use current setting from options.
%
\linespacing{\@thesislnsp}
%
%% Page layout (see The LaTeX Companion pp.84-86).
%% >> Changed in v1.1 on 1998/10/01 by Francois Pitt. << %%
%% >> Changed in v1.4 on 1998/11/05 by Francois Pitt. << %%
%
%% By default, TeX puts the `reference point' one inch down and to
%% the right of the top-left corner of the page.  This moves it back
%% to the top-left corner (making the rest of the layout easier to
%% define).
%
\setlength{\voffset}{-1in}
\setlength{\hoffset}{-1in}
%
%% Instead of hard-coding the page layout for letter paper
%% (8.5" x 11"), we will base it on \paperheight and \paperwidth,
%% so that it works with options that change the paper size.
%
\setlength{\textheight}{\paperheight}
\setlength{\textwidth}{\paperwidth}
%
%% Now, set the margin-dependent values.
%
\ifcase\@marginsize % set narrow margins: 1 1/4" left, 3/4" others
%
\addtolength{\textheight}{-1.5in}
\setlength{\topmargin}{.5in}
\setlength{\headsep}{.25in}
\setlength{\footskip}{.25in}
\addtolength{\textwidth}{-2in}
\setlength{\oddsidemargin}{1.25in}
\setlength{\evensidemargin}{.75in}
\setlength{\marginparwidth}{.5in}
\setlength{\marginparsep}{.125in}
%
\or % set normal margins: 1 1/4" left, 1" others
%
\addtolength{\textheight}{-2in}
\setlength{\topmargin}{.5in}
\setlength{\headsep}{.5in}
\setlength{\footskip}{.5in}
\addtolength{\textwidth}{-2.25in}
\setlength{\oddsidemargin}{1.25in}
\setlength{\evensidemargin}{1in}
\setlength{\marginparwidth}{.75in}
\setlength{\marginparsep}{.125in}
%
\or % set wide margins: 1 1/4" all around
%
\addtolength{\textheight}{-2.5in}
\setlength{\topmargin}{.5in}
\setlength{\headsep}{.75in}
\setlength{\footskip}{.75in}
\addtolength{\textwidth}{-2.5in}
\setlength{\oddsidemargin}{1.25in}
\setlength{\evensidemargin}{1.25in}
\setlength{\marginparwidth}{.75in}
\setlength{\marginparsep}{.25in}
%
\or % set extra wide margins: 1 1/2" all around
%
\addtolength{\textheight}{-3in}
\setlength{\topmargin}{.75in}
\setlength{\headsep}{.75in}
\setlength{\footskip}{.75in}
\addtolength{\textwidth}{-3in}
\setlength{\oddsidemargin}{1.5in}
\setlength{\evensidemargin}{1.5in}
\setlength{\marginparwidth}{1in}
\setlength{\marginparsep}{.25in}
%
\fi%@marginsize
%
%% Adjust \headsep to include height of running head.
%
\addtolength{\headsep}{-\headheight}
%
%% Adjust the vertical spacing between the main text and the notes,
%% and between successive notes if they are not single-spaced.
%% >> Added in v1.2 on 1998/10/20 by Francois Pitt. << %%
%% >> Changed in v1.3 on 1998/11/01 by Francois Pitt. << %%
%
\setlength{\skip\footins}{.75\baselineskip}
\if@singlespacednotes\else
\let\oldtextsize=\currenttextsize
\footnotesize
\setlength{\marginparpush}{\baselineskip}
\setlength{\footnotesep}{\baselineskip}
\oldtextsize
\fi%@singlespacednotes
%
%% Make each page fill up the entire page.
%
\flushbottom
%
%% Default page style.
%
\pagestyle{utthesis}
%
%% Default values for the required fields.
%
\degree{\mbox{}}
\department{\mbox{}}
\gradyear{\number\year}
\author{\mbox{}}
\title{\mbox{}}
%
%% ...\setcounter{tocdepth}{2}...
%% >> Removed in v1.5 on 1999/02/17 by Francois Pitt. << %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  End of UT-THESIS.CLS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
