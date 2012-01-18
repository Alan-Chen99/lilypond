%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.15.20"

\header {
%% Translation of GIT committish: 
  texidocfr = "
L'ajout du graveur @code{Bar_engraver} à un contexte @code{ChordNames}
permet d'imprimer les barres de mesure entre les chiffrages.

"
  doctitlefr = "Chiffrages et barres de mesure"

  lsrtags = "chords"




%% Translation of GIT committish: 6977ddc9a3b63ea810eaecb864269c7d847ccf98
  texidoces = "
Para añadir indicaciones de línea divisoria dentro del contexto de
los nombres de acorde @code{ChordNames}, incluya el grabador
@code{Bar_engraver}.

"
  doctitlees = "Añadir barras de compás al contexto de nombres de acorde (ChordNames)"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Um Taktstriche in einem @code{ChordNames}-Kontext anzeigen zu lassen, muss der
@code{Bar_engraver} hinzugefügt werden.

"
  doctitlede = "Tatkstriche in einen ChordNames-Kontext hinzufügen"

  texidoc = "
To add bar line indications in the @code{ChordNames} context, add the
@code{Bar_engraver}.

"
  doctitle = "Adding bar lines to ChordNames context"
} % begin verbatim

\new ChordNames \with {
  \override BarLine #'bar-extent = #'(-2 . 2)
  \consists "Bar_engraver"
}
\chordmode {
  f1:maj7 f:7 bes:7
}


