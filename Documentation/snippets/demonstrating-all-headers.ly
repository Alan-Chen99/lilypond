%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.23.2"

\header {
  lsrtags = "paper-and-layout, text, titles"

  texidoc = "
A demonstration of all headers.

"
  doctitle = "Demonstrating all headers"
} % begin verbatim

\header {
  copyright = "copyright"
  title = "title"
  subtitle = "subtitle"
  composer = "composer"
  arranger = "arranger"
  instrument = "instrument"
  meter = "meter"
  opus = "opus"
  piece = "piece"
  poet = "poet"
  texidoc = "All header fields with special meanings."
  copyright = "public domain"
  enteredby = "jcn"
  source = "urtext"
}

\layout {
  ragged-right = ##f
}

\score {
  \relative c'' { c1 | c | c | c }
}

\score {
   \relative c'' { c1 | c | c | c }
   \header {
     title = "localtitle"
     subtitle = "localsubtitle"
     composer = "localcomposer"
     arranger = "localarranger"
     instrument = "localinstrument"
     metre = "localmetre"
     opus = "localopus"
     piece = "localpiece"
     poet = "localpoet"
     copyright = "localcopyright"
   }
}
