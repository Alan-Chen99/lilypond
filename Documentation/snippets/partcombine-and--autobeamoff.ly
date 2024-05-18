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
  lsrtags = "rhythms"

  texidoc = "
The function of @code{\\autoBeamOff} when used with
@code{\\partCombine} can be difficult to understand. It may be
preferable to use

@code{\\set Staff.autoBeaming = ##f}

instead to ensure that auto-beaming is turned off for the entire
staff.  Use this at a spot in your score where no beam generated by the
auto-beamer is still active.

Internally, @code{\\partCombine} works with four voices -- stem up
single, stem down single, combined, and solo. In order to use
@code{\\autoBeamOff} to stop all auto-beaming when used with
@code{\\partCombine}, it is necessary to use @emph{four} calls to
@code{\\autoBeamOff}.
"

  doctitle = "Partcombine and \\autoBeamOff"
} % begin verbatim


{
  % \set Staff.autoBeaming = ##f % turns off all auto-beaming

  \partCombine {
    \autoBeamOff   % applies to split up-stems
    \repeat unfold 4 a'16
    % \autoBeamOff % applies to combined stems
    \repeat unfold 4 a'8
    \repeat unfold 4 a'16
    % \autoBeamOff % applies to solo
    \repeat unfold 4 a'16
    r4
  } {
    % \autoBeamOff % applies to split down-stems
    \repeat unfold 4 f'8
    \repeat unfold 8 f'16 |
    r4
    \repeat unfold 4 a'16
  }
}
