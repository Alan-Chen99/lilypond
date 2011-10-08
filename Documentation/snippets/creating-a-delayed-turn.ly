%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.14.0"

\header {
  lsrtags = "expressive-marks, editorial-annotations, tweaks-and-overrides"

%% Translation of GIT committish: 2d548a99cb9dba80f2ff035582009477cd37eceb
texidoces = "
La creación de un grupeto circular de anticipación entre dos notas,
donde la nota inferior del grupeto utiliza una alteración, requiere
varias sobreescriturasw de propiedades.  La propiedad
@code{outside-staff-priority} se debe establecer al valor @code{#f}, pues en
caso contrario tendría prioridad sobre la propiedad @code{avoid-slur
property}.  El valor de @code{halign} se utiliza para colocar el
grupeto horizontalmente.

"

doctitlees = "Crear un grupeto de anticipación"



%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Einen Doppelschlag mit Vorhalt zu erstellen, wobei die untere Note das
Vorzeichen benutzt, erfordert einige Einstellungsänderungen.  Die
@code{outside-staff-priority}-Eigenschaft muss auf falsch (@code{#f})
gesetzt werden, weil sie sonst über die Eigenschaft
@code{avoid-slur property} dominieren würde.  Der Wert von @code{halign}
wird benutzt, um den Doppelschlag horizontal zu positionieren.
"

  doctitlede = "Einen  Doppelschlag mit Vorhalt erstellen"

%% Translation of GIT committish: 4ab2514496ac3d88a9f3121a76f890c97cedcf4e
  texidocfr = "
Obtenir un @emph{grupetto} retardé et dans lequel la note la plus basse
est altérée requiert quelques surcharges.  La propriété
@w{@code{outside-staff-priority}} doît être désactivée (@code{#f}) pour
éviter qu'elle prenne le pas sur la propriété @w{@code{avoid-slur}}.  La
valeur assignée à @code{halign} permet de gérer horizonalement le
@w{« retard »}.

"

  doctitlefr = "Création d'un grupetto retardé"

  texidoc = "
Creating a delayed turn, where the lower note of the turn uses the
accidental, requires several overrides.  The
@code{outside-staff-priority} property must be set to @code{#f}, as
otherwise this would take precedence over the @code{avoid-slur
property}.  The value of @code{halign} is used to position the turn
horizontally.

"
  doctitle = "Creating a delayed turn"
} % begin verbatim

\relative c'' {
  \once \override TextScript #'avoid-slur = #'inside
  \once \override TextScript #'outside-staff-priority = ##f
  c2(^\markup \tiny \override #'(baseline-skip . 1) {
    \halign #-4
    \center-column {
      \sharp
      \musicglyph #"scripts.turn"
    }
  }
  d4.) c8
}
