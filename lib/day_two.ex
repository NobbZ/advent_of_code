defmodule AdventOfCode.DayTwo do
  def a(input) do
    input
    |> String.split
    |> Enum.map(&parse_to_triple/1)
    |> Enum.map(&calc_wrapping_paper/1)
    |> Enum.sum
  end

  defp parse_to_triple(input) do
    [l, w, h] = input |> String.split("x")
    {String.to_integer(l), String.to_integer(w), String.to_integer(h)}
  end

  defp calc_wrapping_paper(dims) do
    areas = get_areas(dims)
    area = areas
    |> Enum.map(&(2 * &1))
    |> Enum.sum
    area + Enum.min(areas)
  end

  defp get_areas({l, w, h}) do
    [l * w, l * h, w * h]
  end
end
