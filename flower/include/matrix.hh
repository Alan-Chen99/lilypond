/*
  This file is part of LilyPond, the GNU music typesetter.

  Copyright (C) 2006--2022 Joe Neeman <joeneeman@gmail.com>

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

#ifndef MATRIX_HH
#define MATRIX_HH

#include <algorithm>
#include <cassert>
#include <vector>

template <class T, class A = std::allocator<T>>
class Matrix
{
  using Vector = std::vector<T, A>;
  using size_type = typename Vector::size_type;

public:
  Matrix () = default;

  Matrix (size_type rows, size_type columns, T const &t)
    : data_ (rows * columns, t),
      rows_ (rows)
  {
  }

  const T &at (size_type row, size_type col) const
  {
    assert (row < rows_ && col * rows_ + row < data_.size ());

    return data_[col * rows_ + row];
  }

  T &at (size_type row, size_type col)
  {
    assert (row < rows_ && col * rows_ + row < data_.size ());

    return data_[col * rows_ + row];
  }

  void resize (size_type rows, size_type columns, T const &t)
  {
    if (rows == rows_)
      data_.resize (rows * columns, t);
    else
      {
        Vector new_data (rows * columns, t);
        const auto cur_cols = rows_ ? (data_.size () / rows_) : 0;
        const auto copy_cols = std::min (columns, cur_cols);
        const auto copy_rows = std::min (rows, rows_);
        for (size_type col = 0; col < copy_cols; ++col)
          std::copy_n (&data_[col * rows_], copy_rows, &new_data[col * rows]);
        rows_ = rows;
        data_ = std::move (new_data);
      }
  }

private:
  Vector data_;
  size_type rows_ = 0;
};

#endif /* MATRIX_HH */
