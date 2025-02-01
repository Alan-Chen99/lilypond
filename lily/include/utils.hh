#pragma once

#include <memory>
#include <string>
#include <cxxabi.h>

namespace extra_utils
{

template <auto V>
struct constant
{
};

template <class T>
auto
type_name () -> std::string
{
  int status = 0;
  std::unique_ptr<char, decltype (&std::free)> res {
    abi::__cxa_demangle (typeid (T).name (), nullptr, nullptr, &status),
    std::free};
  return (status == 0) ? res.get () : typeid (T).name ();
}
template <class T>
auto
type_name (const T &v) -> std::string
{
  int status = 0;
  std::unique_ptr<char, decltype (&std::free)> res {
    abi::__cxa_demangle (typeid (v).name (), nullptr, nullptr, &status),
    std::free};
  return (status == 0) ? res.get () : typeid (T).name ();
}

std::string process_constant_name (std::string x);

template <auto V>
auto
type_name () -> std::string
{
  return process_constant_name (type_name<constant<V>> ());
}

} // namespace extra_utils
