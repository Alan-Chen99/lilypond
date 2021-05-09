%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.23.2"

\header {
  lsrtags = "text, tweaks-and-overrides"

  texidoc = "
The default font families for text can be overridden with
@code{make-pango-font-tree}.

"
  doctitle = "Changing the default text font family"
} % begin verbatim

%{
You may have to install additional fonts.

Red Hat Fedora

  dejavu-fonts-all

Debian GNU/Linux, Ubuntu

  fonts-dejavu-core
  fonts-dejavu-extra
%}

\paper {
  % change for other default global staff size.
  myStaffSize = #20
  %{
     run
         lilypond -dshow-available-fonts
     to show all fonts available in the process log.
  %}

  #(define fonts
    (make-pango-font-tree "DejaVu Serif"
                          "DejaVu Sans"
                          "DejaVu Sans Mono"
     (/ myStaffSize 20)))
}

{
  g'''4^\markup {
    DejaVu Serif: \bold bold
                  \italic italic
                  \italic \bold { bold italic }
  }
  g4_\markup {
    \override #'(font-family . sans) {
      DejaVu Sans: \bold bold
                   \italic italic
                   \italic \bold { bold italic }
    }
  }
  g''2^\markup {
    \override #'(font-family . typewriter) {
      DejaVu Sans Mono: \bold bold
                        \italic italic
                        \italic \bold { bold italic }
    }
  }
}
