\header {

  texidoc = "The vertical positions of staff lines may be specified
  individually, by setting the @code{line-positions} property of the
  StaffSymbol."

}

\version "2.14.0"


\new Staff \relative c'  {
  \override Staff.StaffSymbol #'line-positions = #'(-7 -2 0 3 9)
  g c f b \bar ":|" e a
}
