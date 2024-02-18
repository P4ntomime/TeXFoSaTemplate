# TexFoSaTemplate
LaTeX  Formelsammlungs-template


# Documentation
## Sectioning
Section commands (`\section{}`{:.TeX} , `\subsection{}`{:.TeX} , `\subsubsection{}`{:.TeX}) have been expanded to take an additional (optional) argument to reference pages in a script. It can be used as follows:

```TeX
\section{<section-title>}{<script-page>}
```
However the default commands stay available as well! (without the second argument)

An additional sectioning command has been added: `\example{}`{:.TeX}

In simple terms: it's the same as `\subsubsection{}`{:.TeX} with the addition of removing the section number and adding _Beispiel:_ in front of the text.


## Layout
There is a custom `layout` environment define, which automatically adjusts layout parameters, depending on page orientation.
 - **Landscape:** no titlepage, no table of contents, title in first column (1. page only), 3 columns for rest
 - **Portrait:** titlepage with title and table of contents, 2 columns for rest
 - **Both:** Title, QR-Code to repository, Authors, etc.; Page number in footer


## Custom Commands
Some custom commands have been defined to aid with certain things. More commands can and will be added in the forseeable future.

Here's a list of the current commands (2024-02-18):

| **command**           | **description** |
|-----------------------|-----------------|
| `\myul{}`             | Custom underline command for underline exclusions on letters such as g, j, p, etc. |
| `\example{}`          | Additional sectioning command to ease the addition of examples. |
| `\tikznode{<1>}{<2>}` | Enables creation of inline Ti_k_Z-nodes for later referencing in Ti_k_Z-images.<br> - `<1>`: node name<br> - `<2>`: text to be displayed          |
| `\mybox{}`            | tcolorbox with _backcolor_ (global color definition) as background color. |
| `\textrightarrow`     | Overrides default `\textrightarrow` to match arrow head to Ti_k_Z arrows. |
| `\textlrarrow`        | Additional text left-right-arrow (also matching Ti_k_Z arrows). |
| `\bbr{<1>}{<2>}`      | Colored big braces in math mode (might be removed in the future if not needed).<br>- `<1>`: color<br>- `<2>`: content between braces              |
| `\cgn{}`              | Short-command for green text. |
| `\crd{}`              | Short-command for red text. |
| `\cbl{}`              | Short-command for blue text. |
| `\cor{}`              | Short-command for orange text. |
| `\cvt{}`              | Short-command for violet text. |
| `\tabitem`            | Item bullet if it is needed inside a tabular <br>(avoid using it, as most things can be achieved with itemize, enumerate or outline environments) |
| `\diff{}`             | Differential "d" (not slanted) for derivatives and integrals. |
| `\limes{}`            | Underset limes operator. |
| `\abs{}`              | Absoulte value. Automatically adds left and right bars. |



## How to Handle Changes to `pream.sty`
Changes are either to be requested here on Github, creating a feature request or implemented on your own with an additional commit. In the future this might be handled with pull-requests. You will be informed once this is the case.