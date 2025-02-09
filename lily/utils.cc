#include <iostream>

#include "format_utils.hh"

namespace extra_utils
{

std::string
process_constant_name (std::string x)
{
  auto i = x.find ('<');
  auto ans = x.substr (i + 1, x.length () - 2 - i);

  auto &from = "scm_unused_struct*";

  size_t start_pos;
  while ((start_pos = ans.find (from, 0)) != std::string::npos)
    {
      ans.replace (start_pos, strlen (from), "SCM");
    }
  return ans;
};

void
padded_writer::write_nonl (std::string_view s)
{
  if (s.empty ())
    {
      return;
    }
  if (startofline)
    {
      w->write_str (indent);
    }
  startofline = false;
  w->write_str (s);
}
void
padded_writer::write_nl ()
{
  w->write_str ("\n");
  startofline = true;
}
void
padded_writer::write_str (std::string_view s)
{
  if (s.empty ())
    return;
  bool first = true;

  size_t cur = 0;
  do
    {
      auto nx = s.find ('\n', cur);
      auto ed = (nx == s.npos) ? s.size () : nx;
      if (!first)
        {
          write_nl ();
        }
      first = false;
      write_nonl (s.substr (cur, ed - cur));
      cur = ed + 1;
    }
  while (cur < s.size ());

  if (s.back () == '\n')
    {
      write_nl ();
    }
};

int indent = 0;
with_indent::with_indent ()
{
  indent++;
}
with_indent::~with_indent ()
{
  indent--;
}

struct stderr_writer_noindent : public writer
{
  void write_str (std::string_view s) override { std::cerr << s; }
};

void
stderr_writer::write_str (std::string_view s)
{
  auto indt = std::string (static_cast<size_t> (indent * 2), ' ');
  auto w = stderr_writer_noindent ();
  auto pw = padded_writer (&w, indt);
  pw.startofline = startofline;
  pw.write_str (s);
  startofline = pw.startofline;
}

void
format (writer &w, const SCM &x)
{
  w << from_scm<std::string> (scm_object_to_string (x, SCM_UNDEFINED));
}

void
format (writer &w, const Rational &x)
{
  w << x.to_string ();
}

} // namespace extra_utils
