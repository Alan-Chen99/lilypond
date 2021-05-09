%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.23.2"

\header {
  lsrtags = "expressive-marks"

  texidoc = "
Some composers write two @emph{slurs} when they want legato
chords.  This can be achieved by setting @code{doubleSlurs}.

"
  doctitle = "Using double slurs for legato chords"
} % begin verbatim

\relative c' {
  \set doubleSlurs = ##t
  <c e>4( <d f> <c e> <d f>)
}
