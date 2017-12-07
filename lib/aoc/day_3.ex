defmodule AoC15.Day3 do
  def a(input) do
    input
    |> String.trim
    |> move_around
  end

  def b(input) do
    input
    |> String.trim
    |> move_around_with_robot
  end

  defp move_around(input), do: move_around(input, {0, 0}, MapSet.new)
  #defp move_around(input, coord \\ {0, 0}, visited \\ HashSet.new)
  defp move_around("", coord, visited) do
    visited
    |> MapSet.put(coord)
    |> MapSet.size
  end

  defp move_around(<<d :: utf8>> <> input, coords, visited) do
    move_around(input, move_one(coords, d), MapSet.put(visited, coords))
  end

  defp move_around_with_robot(input), do: move_around_with_robot(input, {0, 0}, {0, 0}, MapSet.new)
  #  defp move_around_with_robot(input, santa \\ {0, 0}, robo \\ {0, 0}, visited \\ HashSet.new)
  defp move_around_with_robot("", santa, robo, visited) do
    visited
    |> MapSet.put(santa)
    |> MapSet.put(robo)
    |> MapSet.size
  end

  defp move_around_with_robot(<<sd :: utf8, rd :: utf8>> <> input, santa, robo, visited) do
    visited = visited
    |> MapSet.put(santa)
    |> MapSet.put(robo)

    santa = santa |> move_one(sd)
    robo = robo |> move_one(rd)

    move_around_with_robot(input, santa, robo, visited)
  end

  defp east({x, y}), do: {x + 1, y}
  defp south({x, y}), do: {x, y - 1}
  defp west({x, y}), do: {x - 1, y}
  defp north({x, y}), do: {x, y + 1}

  defp move_one(coords, d) when not is_binary(d), do: move_one(coords, <<d>>)
  defp move_one(coords, ">"), do: east(coords)
  defp move_one(coords, "v"), do: south(coords)
  defp move_one(coords, "<"), do: west(coords)
  defp move_one(coords, "^"), do: north(coords)
end
