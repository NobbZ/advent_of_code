defmodule AoC15.Day6 do
  def a(input) do
    input
    |> String.strip
    |> String.split("\n")
    |> Enum.map(&parse_instruction/1)
    |> Enum.map(&rewrite_instruction/1)
    |> Enum.reduce(MapSet.new, &apply_instructions/2)
    |> Set.size
  end

  def b(input) do
    input
    |> String.strip
    |> String.split("\n")
    |> Enum.map(&parse_instruction/1)
    |> Enum.map(&rewrite_instruction/1)
    |> Enum.reduce(Map.new, &apply_instructions_b/2)
    |> Map.values
    |> Enum.sum
  end

  defp parse_instruction("turn on " <> tail), do: {:turn_on, get_area(tail)}
  defp parse_instruction("turn off " <> tail), do: {:turn_off, get_area(tail)}
  defp parse_instruction("toggle " <> tail), do: {:toggle, get_area(tail)}

  defp rewrite_instruction({tok, area}), do: {tok, area_to_list(area)}

  defp area_to_list({{x1, y1}, {x2, y2}}), do: for x <- x1..x2, y <- y1..y2, do: {x, y}

  defp apply_instructions({:turn_on, fields}, acc), do: Enum.reduce(fields, acc, fn (f, set) -> MapSet.put(set, f) end)
  defp apply_instructions({:turn_off, fields}, acc), do: Enum.reduce(fields, acc, fn (f, set) -> MapSet.delete(set, f) end)
  defp apply_instructions({:toggle, fields}, acc), do: Enum.reduce(fields, acc, fn (f, set) -> if MapSet.member?(set, f), do: MapSet.delete(set, f), else: MapSet.put(set, f) end)

  defp apply_instructions_b({:turn_on, fields}, acc), do: Enum.reduce(fields, acc, fn (f, map) -> Map.update(map, f, 1, &(&1 + 1)) end)
  defp apply_instructions_b({:turn_off, fields}, acc), do: Enum.reduce(fields, acc, fn (f, map) -> Map.update(map, f, 0, &(if &1 - 1 <= 0, do: 0, else: &1 - 1)) end)
  defp apply_instructions_b({:toggle, fields}, acc) do
    acc = apply_instructions_b({:turn_on, fields}, acc)
    apply_instructions_b({:turn_on, fields}, acc)
  end

  defp get_area(str) do
    str
    |> String.split(" through ")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn (x) -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.map(fn [x, y] -> {x, y} end)
    |> List.to_tuple
  end
end
