%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.4"

\header {
%% Translation of GIT committish: ae814f45737bd1bdaf65b413a4c37f70b84313b7
  texidocfr = "
Certains auteurs utilisent deux liaisons lorsqu'ils veulent
lier des accords. Dans LilyPond, il faut pour cela activer
la propriété @code{doubleSlurs} :

"
  doctitlefr = "Accords et double liaison d'articulation"


  lsrtags = "expressive-marks"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Algunos compositores escriben dos ligaduras cuando quieren acordes
legato.  Esto se puede conseguir estableciendo @code{doubleSlurs}.

"
  doctitlees = "Utilizar ligaduras dobles para acordes legato"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
texidocde = "
Einige Komponisten schreiben doppelte Bögen, wenn Legato-Akkorde notiert
werden.  Das kann mit der Eigenschaft @code{doubleSlurs} erreicht werden.

"
  doctitlede = "Doppelte Bögen für Legato-Akkorde benutzen"

  texidoc = "
Some composers write two slurs when they want legato chords.  This can
be achieved by setting @code{doubleSlurs}.

"
  doctitle = "Using double slurs for legato chords"
} % begin verbatim

\relative c' {
  \set doubleSlurs = ##t
  <c e>4( <d f> <c e> <d f>)
}

