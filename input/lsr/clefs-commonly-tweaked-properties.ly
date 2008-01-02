%% Do not edit this file; it is auto-generated from LSR!
%% Tags: pitches, staff-notation, editorial-and-educational-use, tweaks-and-overrides
\version "2.11.35"

\header { texidoc = "
The command @code{\\clef \"treble_8\"} is equivalent to setting
@code{clefGlyph}, @code{clefPosition} (which controls the Y position of
the clef), @code{middleCPosition} and @code{clefOctavation}.  A clef is
printed when any of these properties are changed.


Note that changing the glyph, the position of the clef, or the
octavation, does not in itself change the position of subsequent notes
on the staff: the position of middle C must also be specified to do
this. The positional parameters are relative to the staff centre line,
positive numbers displacing upwards, counting 1 for each line and
space. The clefOctavation value would normally be set to 7, -7, 15 or
-15, but other values are not invalid.


When a clef change takes place at a line break the new clef symbol is
printed at both the end of the previous line and the beginning of the
new line by default. If the warning clef at the end of the previous
line in not required it can be suppressed by setting the
explicitClefVisibility Staff property to the value  @code{
end-of-line-invisible: \\set Staff.explicitClefVisibility =
#end-of-line-invisible  } The default behaviour can be recovered with 
@code{\\unset Staff.explicitClefVisibility}
% begin verbatim

The following examples show the possibilities when setting these
properties manually. On the first line, the manual changes preserve the
standard relative positioning of clefs and notes, whereas on the second
line, they do not. 
" }

{
           % The default treble clef
           c'4
           % The standard bass clef
           \set Staff.clefGlyph = #"clefs.F"
           \set Staff.clefPosition = #2
           \set Staff.middleCPosition = #6
           c'4
           % The baritone clef
           \set Staff.clefGlyph = #"clefs.C"
           \set Staff.clefPosition = #4
           \set Staff.middleCPosition = #4
           c'4
           % The standard choral tenor clef
           \set Staff.clefGlyph = #"clefs.G"
           \set Staff.clefPosition = #-2
           \set Staff.clefOctavation = #-7
           \set Staff.middleCPosition = #1
           c'4
           % A non-standard clef
           \set Staff.clefPosition = #0
           \set Staff.clefOctavation = #0
           \set Staff.middleCPosition = #-4
           c'4 \break

           % The following clef changes do not preserve
           % the normal relationship between notes and clefs:

           \set Staff.clefGlyph = #"clefs.F"
           \set Staff.clefPosition = #2
           c'4
           \set Staff.clefGlyph = #"clefs.G"
           c'4
           \set Staff.clefGlyph = #"clefs.C"
           c'4
           \set Staff.clefOctavation = #7
           c'4
           \set Staff.clefOctavation = #0
           \set Staff.clefPosition = #0
           c'4
           \set Staff.middleCPosition = #4
           c'4
         }
