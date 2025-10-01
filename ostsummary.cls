% Class definition for OST summary template, based on extarticle
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ostsummary}[2025-02-10 OST Summary Template]

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
% TODO: add following options: 
%  - title
%  - shorttitle
%  - lecturer (dozent)
%  - semester
%  - author
%  - repository/repo
%  - version
%  - titleoption: regular, compact, ultra compact
%  - enabletoc
%  - pagelimit: number [1;oo] or None
%  - seccolor 
%     - +textcolor
%  - subseccolor 
%     - +textcolor
%  - debug
%     - showframe
%  - rounded corners for titles
%  - default underlining for subsubsections
%  - Multiline for titles (no textheight restriction)
%  (- para/paragraph behaviour (default or new with different behaviour for para and paragraph))
%  - font(?)
%  - default appendices
% \bool_new:N \g__dbg_showframe

\ExplSyntaxOn

\bool_new:N \l_bool_dbg_showframe
\bool_new:N \l_bool_enabletoc
\int_new:N \l_int_tocdepth
\int_new:N \l_int_pagelimit
\str_new:N \l_str_color_section_bg
\str_new:N \l_str_color_section_fg
\str_new:N \l_str_color_subsection_bg
\str_new:N \l_str_color_subsection_fg
\dim_new:N \l_dim_margin_top
\dim_new:N \l_dim_margin_bottom
\dim_new:N \l_dim_margin_left
\dim_new:N \l_dim_margin_right
\dim_new:N \l_dim_margin_headheight
\dim_new:N \l_dim_margin_headsep
\dim_new:N \l_dim_margin_footskip

\DeclareKeys{%
    % Debug options: only showframe from geometry for now...
    debug / frame .bool_set:N = \l_bool_dbg_showframe,
    debug / frame .usage:n    = load,
    % frame     .code:n     = \PassOptionsToPackage{showframe}{geometry},

    % enable or disable table of contents
    enabletoc .bool_set:N = \l_bool_enabletoc,
    enabletoc .usage:n    = load,

    % depth of table of content (default: 2)
    tocdepth .int_set:N = \l_int_tocdepth,
    tocdepth .initial:n = 2,
    
    % optional pagelimit
    pagelimit .int_set:N = \l_int_pagelimit,
    pagelimit .usage:n   = load,
    pagelimit .initial:n = 0, % 0 is equal to no pagelimit

    % title(page) options. Only applicable in portrait orientation
    title~option .choice:,
    % TODO: implement this
    title~option / regular       .code:n = \typeout{Option a},
    title~option / compact       .code:n = \typeout{Option b},
    title~option / ultra~compact .code:n = \typeout{Option c},

    % colors handled as strings for now
    colors / section / bg    .str_set:N = \l_str_color_section_bg,
    colors / section / bg    .initial:n = {b4b3b2},
    colors / section / fg    .str_set:N = \l_str_color_section_fg,
    colors / section / fg    .initial:n = {000000},
    colors / subsection / bg .str_set:N = \l_str_color_subsection_bg,
    colors / subsection / bg .initial:n = {dcdbdb},
    colors / subsection / fg .str_set:N = \l_str_color_subsection_fg,
    colors / subsection / fg .initial:n = {000000},
    
    % page margins
    spacing / margins / top        .dim_set:N = \l_dim_margin_top,
    spacing / margins / top        .initial:n = {3mm},
    spacing / margins / bottom     .dim_set:N = \l_dim_margin_bottom,
    spacing / margins / bottom     .initial:n = {6mm},
    spacing / margins / left       .dim_set:N = \l_dim_margin_left,
    spacing / margins / left       .initial:n = {3mm},
    spacing / margins / right      .dim_set:N = \l_dim_margin_right,
    spacing / margins / right      .initial:n = {3mm},
    spacing / margins / headheight .dim_set:N = \l_dim_margin_headheight,
    spacing / margins / headheight .initial:n = {0mm},
    spacing / margins / headsep    .dim_set:N = \l_dim_margin_headsep,
    spacing / margins / headsep    .initial:n = {0mm},
    spacing / margins / footskip   .dim_set:N = \l_dim_margin_footskip,
    spacing / margins / footskip   .initial:n = {4mm},

    % handle all unknown keys
    unknown .code:n = \ostsummary@unknown ,
}


% handle all unknown keys (copied from beautybook.cls class)
\clist_new:N \ostsummary@unknownoptions
\cs_new_protected:Npn \ostsummary@unknown
{
    \bool_if:NTF \l__keys_no_value_bool
    { % eg. 12pt, twoside
        \clist_put_right:Nx \ostsummary@unknownoptions
        { \l_keys_key_str }
    }
    { % eg. zihao=4, fontset=windows
        \clist_put_right:Nx \ostsummary@unknownoptions
        { \l_keys_key_str = { \exp_not:o \l_keys_value_tl } }
    }
}

% If we don't know the key, pass it to the `extarticle` class
\ProcessKeyOptions
\PassOptionsToClass{\ostsummary@unknownoptions}{extarticle}
\PassOptionsToClass{8pt, a4paper}{extarticle}
\LoadClass{extarticle}[1996/10/08]

\ExplSyntaxOff

% ========================= Titling command definitions =========================
% TODO: make fix so currently existing summaries still work with new package
\DeclareRobustCommand\title[1]{\DeclareRobustCommand\@title{#1}}
\DeclareRobustCommand*\@title{}

\DeclareRobustCommand\shorttitle[1]{\DeclareRobustCommand\@shorttitle{#1}}
\DeclareRobustCommand*\@shorttitle{}

\DeclareRobustCommand\semester[1]{\DeclareRobustCommand\@semester{#1}}
\DeclareRobustCommand*\@semester{}

\DeclareRobustCommand\lecturer[1]{\DeclareRobustCommand\@lecturer{#1}}
\DeclareRobustCommand*\@lecturer{}

\DeclareRobustCommand\repository[1]{\DeclareRobustCommand\@repository{#1}}
\DeclareRobustCommand*\@repository{}

\DeclareRobustCommand\version[1]{\DeclareRobustCommand\@version{#1}}
\DeclareRobustCommand*\@version{}

% \SetKeys[ostsummary]{%
%     debug / frame = true
% }
% \keys_define:nn {ostsummary}{%
%     draft   .bool_set:N     = z,
%     draft   .usage:n        = load,
%     draft   .default:n      = {false},
%     dbg   .str_set:N      = \l_ostsummary_dbg_str,
%     dbg   .usage:n        = load,
%     dbg   .default:n      = showframe
% }
% \ProcessKeyOptions%[ostsummary]


% If we don't know the key, pass it to the extarticle class
% \DeclareUnknownKeyHandler{%
%     \PassOptionsToClass{\CurrentOption}{extarticle}
% }
% \ProcessKeyOptions\relax% For some reason we need this here again, 
% \LoadClass{article}[1996/10/08]



% Pass all unknown keys to the extarticle class and then load it with 8pt and a4paper

% \DeclareOption*{%
%     \PassOptionsToClass{\CurrentOption}{extarticle}%
% }
% \ProcessOptions\relax% For some reason we need this here again, 
                     % even though the doc says \ProcessKeyOptions should do that...

% \LoadClass[8pt, a4paper]{extarticle}[1996/10/08]


% Fonts used
\RequirePackage[utf8]{inputenc}         % input encoding: UTF-8
\RequirePackage[T1]{fontenc}            % font encoding: T1
\RequirePackage{textcomp}               % additional symbols
% TODO: maybe update this to be compliant with l2tabu
\RequirePackage{times}                  % times new roman font
\RequirePackage{inconsolata}            % inconsolata font for listings

% Setup multicol
\RequirePackage{multicol}               % provides multicols environment

% Geometry package for layout margins
\ExplSyntaxOn
% remove following if everything works as it should
% \bool_if:nT{\l_bool_dbg_showframe}{%
%     \PassOptionsToPackage{showframe}{geometry}
% }
\PassOptionsToPackage{%
    top        = \l_dim_margin_top,
    bottom     = \l_dim_margin_bottom,
    left       = \l_dim_margin_left,
    right      = \l_dim_margin_right,
    headheight = \l_dim_margin_headheight,
    headsep    = \l_dim_margin_headsep,
    footskip   = \l_dim_margin_footskip,
    showframe  = \l_bool_dbg_showframe
}{geometry}
\ExplSyntaxOff
\RequirePackage{geometry}

% \ExplSyntaxOn
% set page layout
% \geometry{%
%     left=3mm, 
%     right=3mm, 
%     top=3mm, 
%     bottom=6mm, 
%     headheight=0mm, 
%     headsep=0mm, 
%     footskip=4mm,
%     % \sfrmeTst
%     % showframe = \bool_to_str:c\g__dbg_showframe ,
%     %   showframe,
% }
% \if@ostsummary@dbg@frame%
% \geometry{%
%     showframe=true
% }
% \fi%
% \bool_if:nT{\g__dbg_showframe}{
% }
    
% \bool_show:N \g__dbg_showframe
% \bool_log:N\g__dbg_showframe

% \ExplSyntaxOff
% \ExplSyntaxOff

% TODO: maybe add these as package options:
\setlength{\columnsep}{1.5mm}       % distance between columns
\setlength{\columnseprule}{0.1pt}   % thickness of column separation line
\setlength{\parindent}{0pt}         % no paragraph indentation

% \ExplSyntaxOn
% \setcounter{tocdepth}{\int_use:N \l_int_tocdepth}            % only display sections and subsections in toc
% \ExplSyntaxOff
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


\ExplSyntaxOn

\definecolor{sectionbg}{HTML}{\str_use:N \l_str_color_section_bg}
\definecolor{sectionfg}{HTML}{\str_use:N \l_str_color_section_fg}
\definecolor{subsectionbg}{HTML}{\str_use:N \l_str_color_subsection_bg}
\definecolor{subsectionfg}{HTML}{\str_use:N \l_str_color_subsection_fg}

\ExplSyntaxOff
% \if@ostsummary@draft
% \color{green}
% \fi