%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.10"

\header {
  lsrtags = "vocal-music, tweaks-and-overrides, spacing"

%% Translation of GIT committish: 341940d3830b59f93a80131471d622c2818afddb
  texidoces = "
Este fragmento de código muestra el uso de las propiedades de
contexto @code{alignBelowContext} y @code{alignAboveContext} para
controlar la posición de la letra y los compases de ossia.

"
  doctitlees = "Alineación vertical de la letra y los compases de ossia"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Dieser Schnipsel zeigt, wie man die Kontexteigenschaften
@code{alignBelowContext} und @code{alignAboveContext} benutzen kann, um
die Positionierung von Gesangstext und Ossia-Abschnitten zu kontrollieren.

"
  doctitlede = "Gesangstext und Ossia vertikal ausrichten"
%% Translation of GIT committish: d78027a94928ddcdd18fd6534cbe6d719f80b6e6
  texidocfr = "
Cet exemple illustre la manière de positionner une portée d'ossia et
des paroles à l'aide des propriétés de contexte @code{alignBelowContext}
et @code{alignAboveContext}.  

"
  doctitlefr = "Positionnement d'une ossia et des paroles"


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
        \override StaffSymbol #'staff-space = #(magstep -2)
        \remove "Time_signature_engraver"
      } {
        \times 4/6 {
          \override TextScript #'padding = #3
          c8[^"ossia above" d e d e f]
        }
      }
    >>
  }
>>

