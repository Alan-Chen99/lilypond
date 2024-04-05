\version "2.25.15"

\header {
  lsrtags = "contexts-and-engravers, staff-notation, tweaks-and-overrides"

  texidoc = "
This snippet shows how to use @code{Span_stem_engraver} and
@code{\\crossStaff} to connect stems across staves automatically.

The stem lengths need not be specified, as the variable distance between
noteheads and staves is calculated automatically.  However, it is
important that @code{\\crossStaff} is applied to the correct voice or
staff (i.e., on the opposite side of where a beam is or would be
positioned) to get the desired effect.
"

  doctitle = "Cross-staff stems"
}


\layout {
  \context {
    \PianoStaff
    \consists "Span_stem_engraver"
  }
}

\new PianoStaff <<
  \new Staff {
    <b d'>4 r d'16\> e'8. g8 r\! |
    e'8 f' g'4
      \voiceTwo
      % Down to lower staff
      \crossStaff { e'8 e'8 } e'4 |
  }

  \new Staff {
    \clef bass
    \voiceOne
    % Up to upper staff
    \crossStaff { <e g>4 e, g16 a8. c8 } d |
    g8 f g4 \voiceTwo g8 g g4 |
  }
>>
