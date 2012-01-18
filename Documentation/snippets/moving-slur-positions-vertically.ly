%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.14.0"

\header {
  lsrtags = "expressive-marks, tweaks-and-overrides"

%% Translation of GIT committish: 6977ddc9a3b63ea810eaecb864269c7d847ccf98
  texidoces = "
Se puede ajustar la posición vertical de una ligadura de
expresión utilizando la propiedad @code{positions} del objeto
@code{Slur}.  La propiedad tiene dos parámetros, refiriéndose el
primero al extremo izquierdo de la ligadura y el segundo al derecho.
Los valores de los parámetros no se utilizan por parte de LilyPond
para producir un desplazamiento exacto de la ligadura: más bien
selecciona la colocación que mejor aspecto tiene, teniendo en cuenta
los valores de los parámetros.  Los valores positivos desplazan la
ligadura hacia arriba, y son adecuados a notas que tienen las plicas
hacia abajo.  Los valores negativos desplazan las ligaduras bajas aún
más hacia abajo.

"
  doctitlees = "Desplazar ligaduras de expresión verticalmente"



  texidoc = "
The vertical position of a slur can be adjusted using the
@code{positions} property of @code{Slur}.  The property has 2
parameters, the first referring to the left end of the slur and the
second to the right.  The values of the parameters are not used by
LilyPond to make an exact movement of the slur - instead it selects
what placement of the slur looks best, taking into account the
parameter values.  Positive values move the slur up, and are
appropriate for notes with stems down.  Negative values move downward
slurs further down.

"
  doctitle = "Moving slur positions vertically"
} % begin verbatim

\relative c' {
  \stemDown
  e4( a)
  \override Slur #'positions = #'(1 . 1)
  e4( a)
  \override Slur #'positions = #'(2 . 2)
  e4( a)
  \override Slur #'positions = #'(3 . 3)
  e4( a)
  \override Slur #'positions = #'(4 . 4)
  e4( a)
  \override Slur #'positions = #'(5 . 5)
  e4( a)
  \override Slur #'positions = #'(0 . 5)
  e4( a)
  \override Slur #'positions = #'(5 . 0)
  e4( a)
  \stemUp
  \override Slur #'positions = #'(-5 . -5)
  e4( a)
  \stemDown
  \revert Slur #'positions
  e4( a)
}

