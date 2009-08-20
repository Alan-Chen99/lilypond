%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.4"

\header {
%% Translation of GIT committish: 59968a089729d7400f8ece38d5bc98dbb3656a2b
  texidocfr = "
En interne, la fonction @code{\\ottava} détermine les
propriétés @code{ottavation} (p.ex. en @code{\"8va\"} ou @code{\"8vb\"})
et @code{centralCPosition}.  Vous pouvez modifier le texte d'une marque
d'octaviation en définissant @code{ottavation} après avoir fait appel
à @code{ottava} :

"

  doctitlefr = "Texte des marques d'octaviation"


  lsrtags = "pitches, text"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Internamente, @code{\\ottava} establece las propiedades
@code{ottavation} (por ejemplo, a @code{\"8va\"} o a
@code{\"8vb\"}) y @code{middleCPosition}.  Para sobreescribir el
texto del corchete, ajuste @code{ottavation} después de invocar la
instrucción @code{\\ottava}.

"

  doctitlees = "Texto de octava alta y baja"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
texidocde = "
Intern setzt die @code{set-octavation}-Funktion die Eigenschaften
@code{ottavation} (etwa auf den Wert @code{\"8va\"} oder @code{\"8vb\"})
und @code{middleCPosition}.  Um den Text der Oktavierungsklammer zu
ändern, kann @code{ottavation} manuell gesetzt werden, nachdem
@code{set-octavation} benützt wurde.

"

doctitlede = "Ottava-Text"

  texidoc = "
Internally, @code{\\ottava} sets the properties @code{ottavation} (for
example, to @code{8va} or @code{8vb}) and @code{middleCPosition}.  To
override the text of the bracket, set @code{ottavation} after invoking
@code{\\ottava}.

"
  doctitle = "Ottava text"
} % begin verbatim

{
  \ottava #1
  \set Staff.ottavation = #"8"
  c''1
  \ottava #0
  c'1
  \ottava #1
  \set Staff.ottavation = #"Text"
  c''1
}

