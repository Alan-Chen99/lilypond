% DO NOT EDIT this file manually; it is automatically
% generated from Documentation/snippets/new
% Make any changes in Documentation/snippets/new/
% and then run scripts/auxiliar/makelsr.py
%
% This file is in the public domain.
%% Note: this file works from version 2.14.0
\version "2.14.0"

\header {
%% Translation of GIT committish: 2d548a99cb9dba80f2ff035582009477cd37eceb
  doctitlees = "Marca de pizzicato de chasquido (`pizzicato de Bartók')"
  texidoces = "
El pizzicato de chasquido (también llamado @q{Pizzicato de Bartók}) es un
@q{pizzicato fuerte en que la cuerda se pulsa verticalmente produciendo un
chasquido y rebotando en el diapasón del instrumento} (Wikipedia).  Se
denota mediante una circunferencia con una línea vertical corta que parte
del centro de aquélla hacia fuera.  Aunque LilyPond no tiene ninguna
instrucción predefinida para crear esta marca, es fácil hacer la definición
y colocarla directamente en el archivo de lilypond.
"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  doctitlede = "Bartók-Pizzicato"
  texidocde = "
Das Bartók-Pizzicato @q{ist eine besondere Form des Pizzicato, bei dem der
Spieler die Saite auf das Griffbrett aufschlagen lässt, sodass zusätzlich
zum angeschlagenen Ton ein scharfes, knallendes Geräusch ertönt}
(Wikipedia).  Es wird dargestellt als kleiner Kreis mit einer vertikalen
Linie, die vom Kreiszentrum aus nach oben weist und ein Stück außerhalb des
Kreises endet.  Lilypond hat keinen eigenen Glyphen für dieses Symbol; es
ist aber einfach, direkt eine Definition in die Eingabedatei einzufügen.
"

  lsrtags = "expressive-marks, unfretted-strings"
  texidoc = "
A snap-pizzicato (also known as @qq{Bartok pizzicato}) is a @qq{strong
pizzicato where the string is plucked vertically by snapping and
rebounds off the fingerboard of the instrument} (Wikipedia).  It is
denoted by a circle with a vertical line going from the center upwards
outside the circle.
"
  doctitle = "Snap-pizzicato (\"Bartok pizzicato\")"
} % begin verbatim


\relative c' {
  c4\snappizzicato
  <c' e g>4\snappizzicato
  <c' e g>4^\snappizzicato
  <c, e g>4_\snappizzicato
}
