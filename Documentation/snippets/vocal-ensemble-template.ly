%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.4"

\header {
  lsrtags = "vocal-music, template"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
He aquí una partitura vocal estándar para cuatro voces SATB. Con
grupos mayores, suele ser útil incluir una sección que aparezca en
todas las partes.  Por ejemplo, el compás y la armadura casi siempre
son los mismos para todas. Como en la plantilla \"Himno\", las cuatro
voces se reagrupan en sólo dos pentagramas.

"
  doctitlees = "Plantilla de conjunto vocal"

%% Translation of GIT committish: 06d99c3c9ad1c3472277b4eafd7761c4aadb84ae
  texidocja = "
これは標準の 4 パート SATB (ソプラノ、アルト、テナー、バス) ボーカル譜です。@c
もっと大きな合唱では、すべてのパートで使用されるセクションをインクルードすると@c
便利です。例えば、拍子記号と調号はほとんど常にすべてのパートで同じです。\"賛美@c
歌\" テンプレートのように、4 つのボイスは 2 つの譜にグループ分けされています。"
%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Dieses Beispiel ist für vierstimmigen Gesang (SATB). Bei größeren
Stücken ist es oft sinnvoll, eine allgemeine Variable zu bestimmen,
die in allen Stimmen eingefügt wird. Taktart und Vorzeichen etwa
sind fast immer gleich in allen Stimmen.
"

  doctitlede = "Vorlage für Vokalensemble"

%% Translation of GIT committish: 892286cbfdbe89420b8181975032ea975e79d2f5
  texidocfr = "
Ce fichier constitue un canevas standard de partition pour chœur à
quatre voix mixtes.  Lorsque les ensembles s'étoffent, il est judicieux
de recourrir à une section spécifique incluse dans chacune des parties,
tout particulièrement pour gérer la métrique et la tonalité qui,
la plupart du temps, sont communes à tous les pupitres.  Comme il est
d'usage pour les hymnes, les quatre voix sont réparties sur deux
portées.

"
  doctitlefr = "Ensemble vocal (simple)"

  texidoc = "
Here is a standard four-part SATB vocal score. With larger ensembles,
it is often useful to include a section which is included in all parts.
For example, the time signature and key signature are almost always the
same for all parts. Like in the @qq{Hymn} template, the four voices are
regrouped on only two staves.

"
  doctitle = "Vocal ensemble template"
} % begin verbatim

global = {
  \key c \major
  \time 4/4
}

sopMusic = \relative c'' {
  c4 c c8[( b)] c4
}
sopWords = \lyricmode {
  hi hi hi hi
}

altoMusic = \relative c' {
  e4 f d e
}
altoWords = \lyricmode {
  ha ha ha ha
}

tenorMusic = \relative c' {
  g4 a f g
}
tenorWords = \lyricmode {
  hu hu hu hu
}

bassMusic = \relative c {
  c4 c g c
}
bassWords = \lyricmode {
  ho ho ho ho
}

\score {
  \new ChoirStaff <<
    \new Lyrics = sopranos { s1 }
    \new Staff = women <<
      \new Voice = "sopranos" {
        \voiceOne
        << \global \sopMusic >>
      }
      \new Voice = "altos" {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>
    \new Lyrics = "altos" { s1 }
    \new Lyrics = "tenors" { s1 }
    \new Staff = men <<
      \clef bass
      \new Voice = "tenors" {
        \voiceOne
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo << \global \bassMusic >>
      }
    >>
    \new Lyrics = basses { s1 }
    \context Lyrics = sopranos \lyricsto sopranos \sopWords
    \context Lyrics = altos \lyricsto altos \altoWords
    \context Lyrics = tenors \lyricsto tenors \tenorWords
    \context Lyrics = basses \lyricsto basses \bassWords
  >>
  \layout {
    \context {
      % a little smaller so lyrics
      % can be closer to the staff
      \Staff
      \override VerticalAxisGroup #'minimum-Y-extent = #'(-3 . 3)
    }
  }
}

