%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.14.0"

\header {
  lsrtags = "editorial-annotations, text"

%% Translation of GIT committish: 6977ddc9a3b63ea810eaecb864269c7d847ccf98
  texidoces = "
La instrucción @code{\\whiteout} intercala un rectángulo blanco
debajo de un elemento de marcado.  Este rectángulo blanco no tapa
a ningún otro objeto gráfico, puesto que las líneas del pentagrama
están en una capa inferior a la de la mayor parte de los otros
objetos.

"
  doctitlees = "Poner en blanco las líneas del pentagrama utilizando la instrucción \\whiteout"

  texidoc = "
The @code{\\whiteout} command underlays a markup with a white box.
Since staff lines are in a lower layer than most other grobs, this
white box will not overlap any other grob.

"
  doctitle = "Blanking staff lines using the \\whiteout command"
} % begin verbatim

\layout { ragged-right = ##f }
\relative c' {
  \override TextScript #'extra-offset = #'(2 . 4)
  c2-\markup { \whiteout \pad-markup #0.5 "middle C" } c
}

