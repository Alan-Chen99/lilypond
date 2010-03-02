%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.10"

\header {
  lsrtags = "rhythms"

%% Translation of GIT committish: 341940d3830b59f93a80131471d622c2818afddb
  texidoces = "

Se pueden imprimir los números de compás a intervalos regulares
mediante el establecimiento de la propiedad
@code{barNumberVisibility}.  Aquí los números de compás se
imprimen a cada dos compases excepto al final de la línea.

"

  doctitlees = "Imprimir números de compás a intervalos regulares"


%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Taktnummern können in regelmäßigen Intervallen gesetzt werden, indem
man die Eigenschaft @code{barNumberVisibility} definiert.  In diesem
Beispiel werden die Taktnummern jeden zweiten Takt gesetzt, außer
am Ende einer Zeile.

"
  doctitlede = "Setzen der Taktnummern in regelmäßigen Intevallen"


%% Translation of GIT committish: 21c8461ea87cd670a35a40b91d3ef20de03a0409
  texidocfr = "
Vous pouvez imprimer un numéro de mesure à intervalle régulier plutôt
qu'en tête de chaque ligne seulement, en recourrant à la propriété
@code{barNumberVisibility}.  Voici comment afficher le numéro toutes les
deux mesures sauf en fin de ligne.

"
  doctitlefr = "Imprimer les numéros de mesure à intervalle régulier"

  texidoc = "
Bar numbers can be printed at regular intervals by setting the property
@code{barNumberVisibility}. Here the bar numbers are printed every two
measures except at the end of the line.

"
  doctitle = "Printing bar numbers at regular intervals"
} % begin verbatim

\relative c' {
  \override Score.BarNumber #'break-visibility = #end-of-line-invisible
  \set Score.currentBarNumber = #11
  % Permit first bar number to be printed
  \bar ""
  % Print a bar number every second measure
  \set Score.barNumberVisibility = #(every-nth-bar-number-visible 2)
  c1 | c | c | c | c
  \break
  c1 | c | c | c | c
}

