defmodule AoC15.Day2 do
  @moduledoc false

  use AoC15.Default

  def a(input \\ @input) do
    input
    |> String.split
    |> Enum.map(&parse_to_triple/1)
    |> Enum.map(&calc_wrapping_paper/1)
    |> Enum.sum
  end

  def b(input \\ @input) do
    input
    |> String.split
    |> Enum.map(&parse_to_triple/1)
    |> Enum.map(&calc_ribbon_length/1)
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

  defp calc_ribbon_length({l, w, h}) do
    [l, w, h]
    |> Enum.sort
    |> Enum.take(2)
    |> (fn [a, b] -> 2 * (a + b) end).()
    |> (fn x -> x + l * w * h end).()
  end
end
