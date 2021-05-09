%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.23.2"

\header {
  lsrtags = "spacing, tweaks-and-overrides, vocal-music"

  texidoc = "
This snippet demonstrates the use of the context properties
@code{alignBelowContext} and @code{alignAboveContext} to control the
positioning of lyrics and ossias.

"
  doctitle = "Vertically aligning ossias and lyrics"
} % begin verbatim

\paper {
  ragged-right = ##t
}

\relative c' <<
  \new Staff = "1" { c4 c s2 }
  \new Staff = "2" { c4 c s2 }
  \new Staff = "3" { c4 c s2 }
  { \skip 2
    <<
      \lyrics {
        \set alignBelowContext = #"1"
        lyrics4 below
      }
      \new Staff \with {
        alignAboveContext = #"3"
        fontSize = #-2
        \override StaffSymbol.staff-space = #(magstep -2)
        \remove "Time_signature_engraver"
      } {
        \tuplet 6/4 {
          \override TextScript.padding = #3
          c8[^"ossia above" d e d e f]
        }
      }
    >>
  }
>>
