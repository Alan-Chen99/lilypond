% Do not edit this file; it is automatically
% generated from Documentation/snippets/new
% This file is in the public domain.
%% Note: this file works from version 2.13.4
\version "2.13.10"

\header {
%% Translation of GIT committish: 341940d3830b59f93a80131471d622c2818afddb
  texidoces = "
Para tipografiar las barras agrupadas en la forma @code{3-4-3-2}
en 12/8, en primer lugar tenemos que sobreescribir los finales de
barra predeterminados en 12/8, y después preparar los finales de
barra nuevos:

"
  doctitlees = "Alteración de los finales de barra predeterminados"



%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Um Balken im 12/8-Takt als @code{3-4-3-2} zu gruppieren, muss man zuerst die
Standardwerte für die Balken im 12/8-Takt rückgängig machen und dann die neuen
Werte setzen:

"
  doctitlede = "Standard-Balkenwerte rückgängig machen"



%% Translation of GIT committish: bee31293920d834cd3698f00ddcc2402c3164619
  texidocfr = "
Pour obtenir des ligatures en groupes de @code{3-4-3-2} croches, dans
une mesure à 12/8, il faudra préalablement annuler les réglages par
défaut relatifs à 12/8, puis ajouter nos propres règles :

"
  doctitlefr = "Annulation des règles de ligature par défaut"

  lsrtags = "rhythms"
  texidoc = "
To typeset beams grouped @code{3-4-3-2} in 12/8 it is no longer
necessary first to override the default beam endings in 12/8,and
then to set up the new beaming endings:
"
  doctitle = "Reverting default beam endings"
} % begin verbatim


\relative c'' {
  \time 12/8

  % Default beaming
  a8 a a a a a a a a a a a

  % Set new values for beam endings
  \overrideBeamSettings #'Score #'(12 . 8) #'end
    #'((* . (3 4 3 2)))
  a8 a a a a a a a a a a a
}
