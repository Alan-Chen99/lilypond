#pragma once

#include <string>
#include <sstream>
#include <iostream>

#include <libguile.h>

#include "template_utils.hh"
#include "prob.hh"
#include "rational.hh"
#include "utils.hh"

namespace extra_utils
{

struct writer
{
  writer (const writer &) = delete;
  writer (writer &&) = default;
  auto operator= (const writer &) -> writer & = delete;
  auto operator= (writer &&) -> writer & = default;
  writer () = default;
  ~writer () = default;
  virtual void write_str (std::string_view s) = 0;
  template <typename T, typename>
  auto operator<< (const T &val) -> writer &;
  template <typename T>
  auto operator<< (const T &val) && = delete;
};

struct stderr_writer : public writer
{
  bool startofline = true;
  void write_str (std::string_view s) override;
};
struct string_writer : public writer
{
  std::ostringstream x;
  void write_str (std::string_view s) override { x << s; }
  auto str () { return x.str (); }
};

struct padded_writer : writer
{
  std::string_view indent;
  writer *w;
  bool startofline = true;
  padded_writer (writer *w, std::string_view indent)
    : indent (indent),
      w (w) {};
  void write_str (std::string_view s) override;

private:
  void write_nonl (std::string_view s);
  void write_nl ();
};

struct with_indent
{
  with_indent ();
  ~with_indent ();
};

template <int>
struct priority
{
};

// Formatter_Dispatcher uses ADL to look up `format`
template <int Maxpriority, typename T>
struct Formatter_Dispatcher
{
  static auto format_dispatch (writer &out, const T &val)
  {
    return Formatter_Dispatcher<Maxpriority - 1, T>::format_dispatch (out, val);
  };
};
template <int P, typename T>
  requires requires (const T &val, writer &w) {
    format (w, val, priority<P> {});
  }
struct Formatter_Dispatcher<P, T>
{
  static auto format_dispatch (writer &out, const T &val)
  {
    return format (out, val, priority<P> {});
  }
};
template <typename T>
  requires requires (const T &val, writer &w) { format (w, val); }
struct Formatter_Dispatcher<5, T>
{
  static auto format_dispatch (writer &out, const T &val)
  {
    return format (out, val);
  }
};

template <typename T>
auto
format_dispatch_or_err (writer &w, const T &v)
{
  return Formatter_Dispatcher<5, T>::format_dispatch (w, v);
}

template <typename T>
using format_dispatch_or_err_t = decltype (format_dispatch_or_err (
  std::declval<writer &> (), std::declval<const T &> ()));

template <class... Ts>
using format_dispatch_or_err_many_t
  = template_check_list<format_dispatch_or_err_t<Ts>...>::type;

template <typename T,
          typename = success_or_unwrap<format_dispatch_or_err_t<T>>::get>
auto
writer::operator<< (const T &val) -> writer &
{
  format_dispatch_or_err (*this, val);
  return *this;
}

// catch and error out at priority 0
template <typename V>
struct format_err
{
  using fail = fail_msg<"no valid formater for:", V>::do_fail;
};
template <typename T>
auto format (writer &, const T &, priority<0>) -> template_err<format_err<T>>;

// formatter implmentations
void inline format (writer &w, const std::string_view &val)
{
  w.write_str (val);
}
void inline format (writer &w, const std::string &val)
{
  w.write_str (val);
}
void inline format (writer &w, void *const &val, priority<1>)
{
  std::ostringstream oss;
  oss << val;
  w.write_str (oss.str ());
}
void inline format (writer &w, const char &val, priority<3>)
{
  w.write_str ({&val, 1});
}
template <int N>
void
format (writer &w, const char (&val)[N])
{
  std::string_view sv (val, N - 1);
  w.write_str (sv);
}

template <typename T = void>
struct format_char_err
{
  using fail = fail_msg<"formatting char* is disabled", T>::do_fail;
};

auto format (writer &w, char *const &val,
             priority<4>) -> template_err<format_char_err<>>;
auto format (writer &w, const char *const &val,
             priority<4>) -> template_err<format_char_err<>>;

template <typename T>
  requires requires (const T &val) { std::to_string (val); }
void inline format (writer &w, const T &val, priority<4>)
{
  w.write_str (std::to_string (val));
}

template <typename T>
auto
format (writer &out, T *const &v, priority<4>) -> format_dispatch_or_err_t<T>
{
  if constexpr (!is_template_err<format_dispatch_or_err_t<T>>::value)
    {
      if (v == nullptr)
        {
          out << "(" << type_name<T *> () << ")"
              << "nullptr";
        }
      else
        {
          out << *v;
        }
    }
};

template <typename... Args,
          typename
          = success_or_unwrap<format_dispatch_or_err_many_t<Args...>>::get>
void
print_in (writer &w, const Args &...args)
{
  bool first = true;
  auto write_one = [&] (const auto &arg) {
    if (first)
      first = false;
    else
      w << " ";
    w << arg;
  };
  (void) write_one;
  (write_one (args), ...);
}

template <typename... Args,
          typename
          = success_or_unwrap<format_dispatch_or_err_many_t<Args...>>::get>
void
println (const Args &...args)
{
  auto w = stderr_writer ();
  print_in (w, args...);
  std::cerr << std::endl;
}

void format (writer &w, const SCM &x);
void format (writer &w, const Rational &x);

// void format (writer &w, const Prob &x);
// template <typename T, typename = std::enable_if_t<std::is_base_of_v<Prob, T>>>
// void
// format (writer &w, const T &x, priority<4>)
// {
//   format (w, static_cast<const Prob &> (x));
// }

template <typename T>
  requires requires (const T &x, SCM port, scm_print_state *state) {
    x.print_smob (port, state);
  }
void
format (writer &w, const T &x, priority<3>)
{
  // see scm_object_to_string
  SCM port, result;
  port = scm_mkstrport (SCM_INUM0, SCM_BOOL_F, SCM_WRTNG, __PRETTY_FUNCTION__);
  x.print_smob (port, nullptr);
  result = scm_strport_to_string (port);
  scm_close_port (port);
  w << from_scm<std::string> (result);
}

} // namespace extra_utils
