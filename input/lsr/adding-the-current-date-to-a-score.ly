%% Do not edit this file; it is auto-generated from LSR!
%% Tags: titles
\version "2.11.35"

\header { texidoc = "
I often find it useful to include a date on printed music, so that I
can see if I'm using the latest version, or tell someone else that he
should only use the version after a certain date. A simple solution is
to enter the date manually to the @code{.ly} file. But that's very
error prone. It's easy to forget updating the date. So i thought it
would be useful if you can add the date on which the PDF file is
generated automatically. I did't figure it out myself, but I asked on 
lilypond-user@gnu.org. And guess what? Someone came with an excellent
solution! So thank you very much Toine Schreurs for sending this
solution to the user mailing list. I post it here for future reference.

The solution is to use two scheme functions called @code{strftime} and
@code{localtime}, as shown in the snippet. It is a very flexible
solution, you can format the date just as you like it by adapting the
@code{\"%d-%m-%Y\"} string. See the Guile documentation for more
details on this format string: Formatting Calendar Time.
" }
% begin verbatim
\version "2.11.35"
% first, define a variable to hold the formatted date:
date = #(strftime "%d-%m-%Y" (localtime (current-time)))

% use it in the title block:
\header {
  title = "Including the date!"
  subtitle = \date
}
% begin verbatim
\score {
  \relative c'' {
    c4 c c c
  }
}
% and use it in a \markup block:
\markup {
  \date
}
