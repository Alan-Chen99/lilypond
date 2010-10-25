\version "2.13.37"

\header {
  texidoc = "minimum-distance within a system is correctly accounted for in page breaking."
}

\layout {
  \context {
    \Score
    \override VerticalAxisGroup #'next-staff-spacing = #'((space . 20) (stretchability . 0))
  }
}

music = { c'1 \break c'1 }

\book {
  \paper {
    paper-height = 9\cm
  }

  \score { << \new Staff \music \new Staff \music >> }
}

