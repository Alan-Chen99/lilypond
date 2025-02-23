/*
  This file is part of LilyPond, the GNU music typesetter.

  Copyright (C) 1997--2023 Han-Wen Nienhuys <hanwen@xs4all.nl>

  LilyPond is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  LilyPond is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with LilyPond.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "clef.hh"
#include "context.hh"
#include "engraver.hh"
#include "international.hh"
#include "item.hh"
#include "pitch.hh"
#include "protected-scm.hh"
#include "staff-symbol-referencer.hh"
#include "stream-event.hh"
#include "format_utils.hh"

#include "translator.icc"

constexpr auto &keyAlterations_key = "keyAlterations__hide";
constexpr auto &lastKeyAlterations_key = "lastKeyAlterations__hide";
constexpr auto &tonic_key = "tonic";

class Key_engraver final : public Engraver
{
  void create_key (bool);
  void read_event (Stream_event const *r);

  Stream_event *key_event_ = nullptr;
  Item *item_ = nullptr;
  Item *cancellation_ = nullptr;

public:
  TRANSLATOR_DECLARATIONS (Key_engraver);

protected:
  void initialize () override;
  void finalize () override;
  void stop_translation_timestep ();
  void process_music ();

  void listen_key_change (Stream_event *);
  void acknowledge_clef (Grob_info);
};

void
Key_engraver::finalize ()
{
}

Key_engraver::Key_engraver (Context *c)
  : Engraver (c)
{
}

void
Key_engraver::create_key (bool is_default)
{
  // extra_utils::println (__PRETTY_FUNCTION__);
  // auto _raii = extra_utils::with_indent ();
  if (!item_)
    {
      item_ = make_item ("KeySignature",
                         key_event_ ? key_event_->self_scm () : SCM_EOL);

      /* Use middleCClefPosition rather than middleCPosition, because cue
       * notes with a different clef will modify middleCPosition. The
       * Key signature, however, should still be printed at the original
       * position. */
      set_property (item_, "c0-position",
                    get_property (this, "middleCClefPosition"));

      SCM last = get_property (this, lastKeyAlterations_key);
      SCM key = get_property (this, keyAlterations_key);
      // extra_utils::println ("reading keyAlterations_key:", key);

      if ((from_scm<bool> (get_property (this, "printKeyCancellation"))
           || scm_is_null (key))
          && !scm_is_eq (last, key))
        {
          SCM restore = SCM_EOL;
          for (SCM s = last; scm_is_pair (s); s = scm_cdr (s))
            {
              SCM new_alter_pair = ly_assoc (scm_caar (s), key);
              Rational old_alter = from_scm<Rational> (scm_cdar (s), 0);
              if (scm_is_false (new_alter_pair)
                  || ((from_scm<Rational> (scm_cdr (new_alter_pair))
                       - old_alter)
                        * old_alter
                      < Rational (0)))
                {
                  restore = scm_cons (scm_car (s), restore);
                }
            }

          if (scm_is_pair (restore))
            {
              cancellation_
                = make_item ("KeyCancellation",
                             key_event_ ? key_event_->self_scm () : SCM_EOL);

              set_property (cancellation_, "alteration-alist", restore);
              set_property (cancellation_, "c0-position",
                            get_property (this, "middleCClefPosition"));
            }
        }

      auto alt_alist = scm_reverse (key);
      // extra_utils::println ("setting alteration-alist:", item_, alt_alist);
      set_property (item_, "alteration-alist", alt_alist);
    }

  if (!is_default)
    {
      SCM visibility = get_property (this, "explicitKeySignatureVisibility");
      set_property (item_, "break-visibility", visibility);
      set_property (item_, "non-default", SCM_BOOL_T);
    }
}

void
Key_engraver::listen_key_change (Stream_event *ev)
{
  extra_utils::println (__PRETTY_FUNCTION__);
  auto _raii = extra_utils::with_indent ();

  ev = unsmob<Stream_event> (get_property (ev, "__before_transpose"));
  assert (ev);

  /* do this only once, just to be on the safe side.  */
  if (assign_event_once (key_event_, ev))
    read_event (key_event_);
}

void
Key_engraver::acknowledge_clef (Grob_info /* info */)
{
  SCM c = get_property (this, "createKeyOnClefChange");
  if (from_scm<bool> (c))
    create_key (false);
}

void
Key_engraver::process_music ()
{
  // Efficiency: don't create a KeySignature where it would not be
  // visible anyway.
  if (break_allowed (context ()))
    create_key (true);

  if (key_event_
      || !scm_is_eq (get_property (this, lastKeyAlterations_key),
                     get_property (this, keyAlterations_key)))
    create_key (false);
}

void
Key_engraver::stop_translation_timestep ()
{
  item_ = nullptr;
  set_property (context (), lastKeyAlterations_key,
                get_property (this, keyAlterations_key));
  cancellation_ = nullptr;
  key_event_ = nullptr;
}

void
Key_engraver::read_event (Stream_event const *r)
{
  SCM p = get_property (r, "pitch-alist");
  if (!scm_is_pair (p))
    return;

  SCM accs = SCM_EOL;

  SCM alist = scm_list_copy (p);
  SCM order = get_property (this, "keyAlterationOrder");
  for (SCM s = order; scm_is_pair (s) && scm_is_pair (alist); s = scm_cdr (s))
    {
      SCM head = scm_member (scm_car (s), alist);

      if (scm_is_pair (head))
        {
          accs = scm_cons (scm_car (head), accs);
          alist = scm_delete_x (scm_car (head), alist);
        }
    }

  if (scm_is_pair (alist))
    {
      bool warn = false;
      for (SCM s = alist; scm_is_pair (s); s = scm_cdr (s))
        if (from_scm<Rational> (scm_cdar (s)))
          {
            warn = true;
            accs = scm_cons (scm_car (s), accs);
          }

      if (warn)
        r->warning (_ ("Incomplete keyAlterationOrder for key signature"));
    }

  auto keyalt = scm_reverse_x (accs, SCM_EOL);

  auto tonic_scm = get_property (r, "tonic");
  set_property (context (), keyAlterations_key, keyalt);
  set_property (context (), tonic_key, tonic_scm);

  extra_utils::println ("setting keyAlterations:", keyalt);
  extra_utils::println ("tonic:", tonic_scm);

  auto tonic = unsmob<Pitch> (tonic_scm);
  if (tonic)
    {
      auto tp = tonic->tone_pitch ();
      auto target_shift = (-tp) % 6;
      if (target_shift > 3)
        target_shift -= 6;

      auto diff = pitch_interval (*tonic, Pitch ());
      auto offset = (diff.tone_pitch () - target_shift) / 6;
      diff = pitch_interval (Pitch (static_cast<int> (offset.trunc_int ()), 0),
                             diff);

      assert (diff.tone_pitch () == target_shift);

      extra_utils::println ("transposing by", target_shift);
      set_property (context (), "__transpose", diff.smobbed_copy ());
    }
}

void
Key_engraver::initialize ()
{
  set_property (context (), keyAlterations_key, SCM_EOL);
  set_property (context (), lastKeyAlterations_key, SCM_EOL);
  // set_property (context (), "keyAlterations", SCM_EOL);
  // set_property (context (), "lastKeyAlterations", SCM_EOL);

  Pitch p;
  set_property (context (), "tonic", p.smobbed_copy ());
}

void
Key_engraver::boot ()
{
  ADD_LISTENER (key_change);
  ADD_ACKNOWLEDGER (clef);
}

ADD_TRANSLATOR (Key_engraver,
                /* doc */
                R"(
Engrave a key signature.
                )",

                /* create */
                R"(
KeyCancellation
KeySignature
                )",

                /* read */
                R"(
createKeyOnClefChange
explicitKeySignatureVisibility
extraNatural
forbidBreak
forceBreak
keyAlterationOrder
keyAlterations
keyAlterations__hide
lastKeyAlterations
lastKeyAlterations__hide
printKeyCancellation
middleCClefPosition
                )",

                /* write */
                R"(
keyAlterations
keyAlterations__hide
lastKeyAlterations
lastKeyAlterations__hide
tonic
                )");
