/*
  This file is part of LilyPond, the GNU music typesetter.

  Copyright (C) 2018--2021 Daniel Eble <nine.fierce.ballads@gmail.com>

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

#ifndef MARK_TRACKING_TRANSLATOR_HH
#define MARK_TRACKING_TRANSLATOR_HH

#include "translator.hh"

class Stream_event;

class Mark_tracking_translator final : public Translator
{
private:
  enum class Event_type : unsigned
  {
    none = 0,
    ad_hoc_mark,
    default_rehearsal_mark,
    default_segno_mark,
    specific_rehearsal_mark,
    specific_segno_mark,
  };

public:
  TRANSLATOR_DECLARATIONS (Mark_tracking_translator);
private:
  Stream_event *event_ = nullptr;
  Event_type event_type_ = Event_type::none;
  bool first_time_ = true;

public:
  // Get the label for a rehearsal mark event during process_music ().  It may
  // be specified in the event or come from the context.
  static size_t get_rehearsal_mark_label (const Context *,
                                          const Stream_event *);

  // Get the label for a segno event during process_music ().  It may be
  // specified in the event or come from the context.
  static size_t get_segno_mark_label (const Context *, const Stream_event *);

protected:
  void stop_translation_timestep ();

  void listen_ad_hoc_mark (Stream_event *);
  void listen_rehearsal_mark (Stream_event *);
  void listen_segno_mark (Stream_event *);

private:
  void set_event (Event_type, Stream_event *);
  bool set_event_once (Event_type, Stream_event *);
  void clear_event ();
};

#endif /* MARK_TRACKING_TRANSLATOR_HH */
