%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.23.2"

\header {
  lsrtags = "spacing, tweaks-and-overrides"

  texidoc = "
If @code{strict-note-spacing} is set spacing of notes is not influenced
by bars or clefs within a system. Rather, they are placed just before
the note that occurs at the same time. This may cause collisions.

"
  doctitle = "Proportional strict notespacing"
} % begin verbatim

\relative c'' <<
  \override Score.SpacingSpanner.strict-note-spacing = ##t
  \set Score.proportionalNotationDuration = #(ly:make-moment 1/16)
  \new Staff {
    c8[ c \clef alto c c \grace { d16 } c8 c] c4
    c2 \grace { c16[ c16] } c2
  }
  \new Staff {
    c2 \tuplet 3/2 { c8 \clef bass cis,, c } c4
    c1
  }
>>
