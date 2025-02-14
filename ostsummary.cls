% Class definition for OST summary template, based on extarticle
\NeedsTeXFormat{LaTeX2e}
\ExplSyntaxOn
\ProvidesClass{ostsummary}[2025-02-10]

% \DeclareKeys[ostsummary]{%
%     draft.if        = @ostsummary@draft ,
%     draft.usage     = load ,
%     draft.default:n = false ,
%     debug.store     = \debugTest ,
%     % debug.usage     = load,
%     debug.default:n   = showframe ,
%     debug /showframe.store = \sfrmeTst ,
%     debug /showframe.default:n = showframe ,
% }

\keys_define:nn {ostsummary}{%
    draft   .bool_set:N     = z,
    draft   .usage:n        = load,
    draft   .default:n      = {false},
    dbg   .str_set:N      = \l_ostsummary_dbg_str,
    dbg   .usage:n        = load,
    dbg   .default:n      = showframe
}
\ProcessKeyOptions%[ostsummary]


% If we don't know the key, pass it to the extarticle class
\DeclareUnknownKeyHandler{%
    \PassOptionsToClass{\CurrentOption}{extarticle}
}
\LoadClassWithOptions{extarticle}[1996/10/08]
% \LoadClass{extarticle}[1996/10/08]


% Fonts used
\RequirePackage[utf8]{inputenc}         % input encoding: UTF-8
\RequirePackage[T1]{fontenc}            % font encoding: T1
\RequirePackage{textcomp}               % additional symbols
\RequirePackage{times}                  % times new roman font
\RequirePackage{inconsolata}            % inconsolata font for listings

% Setup multicol
\RequirePackage{multicol}               % provides multicols environment

% Geometry package for layout margins
\RequirePackage{geometry}

% \ExplSyntaxOn
% set page layout
\geometry{%
    left=3mm, 
    right=3mm, 
    top=3mm, 
    bottom=6mm, 
    headheight=0mm, 
    headsep=0mm, 
    footskip=4mm,
    % \sfrmeTst
    \l_ostsummary_dbg_str,
    %   showframe,
}
% \ExplSyntaxOff
\ExplSyntaxOff

\setlength{\columnsep}{1.5mm}       % distance between columns
\setlength{\columnseprule}{0.1pt}   % thickness of column separation line
\setlength{\parindent}{0pt}         % no paragraph indentation

\setcounter{tocdepth}{2}            % only display sections and subsections in toc
% \setcounter{secnumdepth}{0}       % uncomment to disable section numbering

\DeclareMathSizes{8}{8}{6}{5}       % set math font sizes for 8pt document


% Setup math fonts
\RequirePackage{amsmath}                % math symbols
\RequirePackage{amssymb}                % more math symbols
\RequirePackage{mathtools}              % more math tools needed for pmatrix modification
\RequirePackage{mhsetup}                % needed to modify pmatrix environment
\RequirePackage{txfonts}                % Times math font
\RequirePackage[squaren]{SIunits}       % SI-units
\RequirePackage{bm}                     % bold math symbols
\RequirePackage{trfsigns}               % needed for "Laplace" symbol (Korrespondenz)
\RequirePackage{mathrsfs}               % needed for Fourier transform "F"

\RequirePackage{anyfontsize}            % set any font size
\RequirePackage[table]{xcolor}          % needed for colors

% \if@ostsummary@draft
% \color{green}
% \fi