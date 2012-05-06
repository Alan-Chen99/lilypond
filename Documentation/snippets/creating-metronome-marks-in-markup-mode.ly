%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.14.2"

\header {
  lsrtags = "rhythms"

%% Translation of GIT committish: b482c3e5b56c3841a88d957e0ca12964bd3e64fa
  texidoces = "
Se pueden crear indicaciones metronómicas nuevas en modo de
marcado, pero no cambian el tempo en la salida MIDI.

"
  doctitlees = "Crear indicaciones metronómicas en modo de marcado"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Neue Metronombezeichnungen können als Textbeschriftung erstellt werden,
aber sie ändern nicht das Tempo für die MIDI-Ausgabe.

"

  doctitlede = "Eine Metronombezeichnung als Textbeschriftung erstellen"

%% Translation of GIT committish: af3df3b7c6e062635bdccb739be41962969806a0
  texidocfr = "
Vous pouvez créer des indications de tempo sous la forme d'étiquettes
textuelles -- des objets @code{markup} -- notamment des équivalences.
Cependant, elles n'apparaîtront pas dans le fichier MIDI.

"
  doctitlefr = "Création d'une indication métronomique sous forme d'étiquette"


  texidoc = "
New metronome marks can be created in markup mode, but they will not
change the tempo in MIDI output.

"
  doctitle = "Creating metronome marks in markup mode"
} % begin verbatim


\relative c' {
  \tempo \markup {
    \concat {
      (
      \smaller \general-align #Y #DOWN \note #"16." #1
      " = "
      \smaller \general-align #Y #DOWN \note #"8" #1
      )
    }
  }
  c1
  c4 c' c,2
}
