defmodule AoC15.Day5 do
  @moduledoc false

  use AoC15.Default

  def a(input \\ @input) do
    # 1. at least three vowels
    # 2. at least one letter twice in a row
    # 3. none of "ab", "cd", "pq" or "xy"
    input
    |> String.split("\n")
    |> Enum.filter(&naughty_a/1)
    |> Enum.count
  end

  def b(input \\ @input) do
    input
    |> String.split("\n")
    |> Enum.filter(&naughty_b/1)
    |> Enum.count
  end

  defp naughty_a(word), do: naughty_a(String.codepoints(word), 0, false)

  defp naughty_a(word, vowels, dbl)
  defp naughty_a([], vowels, dbl), do: vowels >= 3 && dbl
  defp naughty_a(["a", "b"|_], _vowels, _dbl), do: false
  defp naughty_a(["c", "d"|_], _vowels, _dbl), do: false
  defp naughty_a(["p", "q"|_], _vowels, _dbl), do: false
  defp naughty_a(["x", "y"|_], _vowels, _dbl), do: false
  defp naughty_a([h, h|t], vowels, _dbl), do: naughty_a([h|t], count_vowel(h, vowels), true)
  defp naughty_a([h|t], vowels, dbl), do: naughty_a(t, count_vowel(h, vowels), dbl)

  defp naughty_b(word), do: naughty_b(String.codepoints(word), false, false)

  defp naughty_b(word, pairs, gapped)
  defp naughty_b(_word, true, true), do: true
  defp naughty_b([], pairs, gapped), do: pairs && gapped
  defp naughty_b([a, b, c|t], pairs, gapped), do: naughty_b([b, c|t], find_again(pairs, a, b, [c|t]), gapped || a === c)
  defp naughty_b([_|t], pairs, gapped), do: naughty_b(t, pairs, gapped)

  defp find_again(true, _, _, _), do: true
  defp find_again(false, _, _, []), do: false
  defp find_again(false, a, b, [a, b|_]), do: true
  defp find_again(false, a, b, [_|t]), do: find_again(false, a, b, t)

  defp count_vowel(v, cnt) when v in ["a", "e", "i", "o", "u"], do: cnt + 1
  defp count_vowel(_, cnt), do: cnt
end
