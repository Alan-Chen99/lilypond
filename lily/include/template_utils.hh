#pragma once

#include <array>

// global scope to shorten error messages
template <std::size_t N>
struct fixed_str
{
  std::array<char, N> value;
  constexpr fixed_str (const char (&str)[N])
  {
    std::copy (str, str + N, value.begin ());
  }
};
template <fixed_str msg, typename... args>
struct fail_msg
{
};

namespace extra_utils
{

// used represent a meaningful template error
// T should fail to instantiate and give a readable error message when
// instantiated.
// we cant just have error inherit a plain template_err since
// checking base class requires instantiation
template <typename T>
struct template_err
{
};

template <typename T>
struct is_template_err : std::false_type
{
};
template <typename T>
struct is_template_err<template_err<T>> : std::true_type
{
};

template <typename... args>
struct arglist
{
};

template <typename first, typename list>
struct prepend_arglist;
template <typename first, typename... rest>
struct prepend_arglist<first, arglist<rest...>>
{
  using type = arglist<first, rest...>;
};

template <template <typename> typename F, typename args, typename enable = void>
struct template_split_list
{
};
template <template <typename> typename F, typename first, typename... rest>
struct template_split_list<F, arglist<first, rest...>,
                           std::enable_if_t<F<first>::value>>
{
  using tail = template_split_list<F, arglist<rest...>>;
  using true_list = prepend_arglist<first, typename tail::true_list>::type;
  using false_list = tail::false_list;
};
template <template <typename> typename F, typename first, typename... rest>
struct template_split_list<F, arglist<first, rest...>,
                           std::enable_if_t<!F<first>::value>>
{
  using tail = template_split_list<F, arglist<rest...>>;
  using true_list = tail::true_list;
  using false_list = prepend_arglist<first, typename tail::false_list>::type;
};
template <template <typename> typename F>
struct template_split_list<F, arglist<>>
{
  using true_list = arglist<>;
  using false_list = arglist<>;
};
// using template_split_list_test =
//     template_split_list<std::is_integral, arglist<bool, int, std::nullptr_t,
//     void>>;
// using template_split_list_test1 = template_split_list_test::true_list;
// using template_split_list_test2 = template_split_list_test::false_list;

template <typename res, template <typename> typename map>
struct template_map_ok
{
  using type = map<res>;
};
template <typename res, template <typename> typename map>
struct template_map_ok<template_err<res>, map>
{
  using type = template_err<res>;
};

template <typename oldt, typename newt>
struct error_or
{
  using type = newt;
};
template <typename olderr, typename newt>
struct error_or<template_err<olderr>, newt>
{
  using type = template_err<olderr>;
};

template <typename oklist, typename errlist>
struct check_list_helper;
template <typename vals>
struct check_list_helper<vals, arglist<>>
{
  using res = vals;
};
template <typename vals, typename err, typename... err_rest>
struct check_list_helper<vals, arglist<template_err<err>, err_rest...>>
{
  using res = template_err<err>;
};
template <typename... ts>
struct template_check_list
{
  using filtered = template_split_list<is_template_err, arglist<ts...>>;
  using type = check_list_helper<typename filtered::false_list,
                                 typename filtered::true_list>::res;
};

template <typename T>
struct success
{
  using get = T;
};
template <typename T>
struct success_or_unwrap_impl
{
  using impl = success<T>;
};
template <typename T>
struct success_or_unwrap_impl<template_err<T>>
{
  using impl = T;
};
template <typename T>
using success_or_unwrap = success_or_unwrap_impl<T>::impl;

} // namespace extra_utils
