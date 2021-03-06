defmodule AoC15.Day1 do
  @moduledoc false

  use AoC15.Default

  @input String.trim(@input)

  def a(input \\ @input) when input |> is_binary do
    input
    |> diff_count_parens()
  end

  def b(input \\ @input) when input |> is_binary do
    input
    |> find_floor(-1)
  end

  defp diff_count_parens(input, acc \\ 0)
  defp diff_count_parens("", acc), do: acc
  defp diff_count_parens("(" <> t, acc), do: diff_count_parens(t, acc + 1)
  defp diff_count_parens(")" <> t, acc), do: diff_count_parens(t, acc - 1)

  defp find_floor(input, target), do: find_floor(input, target, 0, 0)
  defp find_floor(_input, target, idx, target), do: idx
  defp find_floor("(" <> input, target, idx, current), do: find_floor(input, target, idx + 1, current + 1)
  defp find_floor(")" <> input, target, idx, current), do: find_floor(input, target, idx + 1, current - 1)
end
