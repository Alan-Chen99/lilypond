%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.10"

\header {
  lsrtags = "staff-notation"

%% Translation of GIT committish: 341940d3830b59f93a80131471d622c2818afddb
  texidoces = "
Se pueden crear indicaciones metronómicas nuevas en modo de
marcado, pero no cambian el tempo en la salida MIDI.

"
  doctitlees = "Crear indicaciones metronómicas en modo de marcado"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Neue Metronombezeichnungen können als Textbeschriftung erstellt werden,
aber sie ändern nicht das Tempo für die MIDI-Ausgabe.

"

  doctitlede = "Eine Metronombezeichnung als Textbeschriftung erstellen"
%% Translation of GIT committish: d78027a94928ddcdd18fd6534cbe6d719f80b6e6
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
