defmodule AdventOfCode.DayOne do
  def a(input) when input |> is_binary do
    input
    |> String.strip
    |> count_parens
    |> diff_parens
  end

  def b(input) when input |> is_binary do
    input
    |> find_floor(-1)
  end

  defp count_parens(input, acc \\ {0, 0})
  defp count_parens("", acc), do: acc
  defp count_parens("(" <> input, {o, c}), do: count_parens(input, {o + 1, c})
  defp count_parens(")" <> input, {o, c}), do: count_parens(input, {o, c + 1})

  defp diff_parens({o, c}), do: o - c

  defp find_floor(input, target, idx \\ 0, current \\ 0)
  defp find_floor(_input, target, idx, target), do: idx
  defp find_floor("(" <> input, target, idx, current), do: find_floor(input, target, idx + 1, current + 1)
  defp find_floor(")" <> input, target, idx, current), do: find_floor(input, target, idx + 1, current - 1)
end
