%% DO NOT EDIT this file manually; it was automatically
%% generated from the LilyPond Snippet Repository
%% (http://lsr.di.unimi.it).
%%
%% Make any changes in the LSR itself, or in
%% `Documentation/snippets/new/`, then run
%% `scripts/auxiliar/makelsr.pl`.
%%
%% This file is in the public domain.

\version "2.24.0"

\header {
  lsrtags = "contemporary-notation, rhythms"

  texidoc = "
Flat flags on lone notes and beam nibs at the ends of beamed figures
are both possible with a combination of @code{stemLeftBeamCount},
@code{stemRightBeamCount}, and paired @code{[]} beam indicators.

For right-pointing flat flags on lone notes, use paired @code{[]} beam
indicators and set @code{stemLeftBeamCount} to zero (see
Example@tie{}1).

For left-pointing flat flags, set @code{stemRightBeamCount} instead
(Example@tie{}2).

For right-pointing nibs at the end of a run of beamed notes, set
@code{stemRightBeamCount} to a positive value.  And for left-pointing
nibs at the start of a run of beamed notes, set
@code{stemLeftBeamCount} instead (Example@tie{}3).

Sometimes it may make sense for a lone note surrounded by rests to
carry both a left- and right-pointing flat flag.  Do this with paired
@code{[]} beam indicators alone (Example@tie{}4).

(Note that @code{\\set stemLeftBeamCount} is always equivalent to
@code{\\once \\set}.  In other words, the beam count settings are not
@qq{sticky}, so the pair of flat flags attached to the lone
@code{c'16[]} in the last example have nothing to do with the
@code{\\set} two notes prior.)
"

  doctitle = "Flat flags and beam nibs"
} % begin verbatim


\score {
  <<
    % Example 1
    \new RhythmicStaff {
      \set stemLeftBeamCount = 0
      c16[]
      r8.
    }
    % Example 2
    \new RhythmicStaff {
      r8.
      \set stemRightBeamCount = 0
      16[]
    }
    % Example 3
    \new RhythmicStaff {
      16 16
      \set stemRightBeamCount = 2
      16 r r
      \set stemLeftBeamCount = 2
      16 16 16
    }
    % Example 4
    \new RhythmicStaff {
      16 16
      \set stemRightBeamCount = 2
      16 r16
      16[]
      r16
      \set stemLeftBeamCount = 2
      16 16
    }
  >>
}
