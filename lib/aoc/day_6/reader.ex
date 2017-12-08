defmodule AoC15.Day6.Reader do
  @moduledoc false

  def read(input) do
    input
    |> String.split("\n")
    |> Stream.reject(&(&1 == ""))
    |> Stream.map(fn
      "turn on "  <> tail -> {:on,  get_area(tail)}
      "turn off " <> tail -> {:off, get_area(tail)}
      "toggle "   <> tail -> {:tgl, get_area(tail)}
    end)
    |> Enum.into([])
  end

  defp get_area(str) do
    str
    |> String.split(" through ")
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(fn (x) -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.map(fn [x, y] -> {x, y} end)
    |> List.to_tuple
  end
end
