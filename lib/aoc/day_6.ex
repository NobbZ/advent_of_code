defmodule AoC15.Day6 do
  @moduledoc false

  use AoC15.Default

  alias AoC15.Day6.Reader

  @input Reader.read(@input)

  def a(input \\ @input) do
    input
    |> Stream.map(&rewrite_instruction/1)
    |> Enum.reduce(MapSet.new, &apply_instructions/2)
    |> MapSet.size
  end

  def b(input \\ @input) do
    input
    |> Stream.map(&rewrite_instruction/1)
    |> Enum.reduce(Map.new, &apply_instructions_b/2)
    |> Map.values
    |> Enum.sum
  end

  defp rewrite_instruction({tok, area}), do: {tok, area_to_list(area)}

  defp area_to_list({{x1, y1}, {x2, y2}}), do: for x <- x1..x2, y <- y1..y2, do: {x, y}

  defp apply_instructions({:on, fields}, acc), do: Enum.reduce(fields, acc, fn (f, set) -> MapSet.put(set, f) end)
  defp apply_instructions({:off, fields}, acc), do: Enum.reduce(fields, acc, fn (f, set) -> MapSet.delete(set, f) end)
  defp apply_instructions({:tgl, fields}, acc), do: Enum.reduce(fields, acc, fn (f, set) -> if MapSet.member?(set, f), do: MapSet.delete(set, f), else: MapSet.put(set, f) end)

  defp apply_instructions_b({:on, fields}, acc), do: Enum.reduce(fields, acc, fn (f, map) -> Map.update(map, f, 1, &(&1 + 1)) end)
  defp apply_instructions_b({:off, fields}, acc), do: Enum.reduce(fields, acc, fn (f, map) -> Map.update(map, f, 0, &(if &1 - 1 <= 0, do: 0, else: &1 - 1)) end)
  defp apply_instructions_b({:tgl, fields}, acc) do
    acc = apply_instructions_b({:on, fields}, acc)
    apply_instructions_b({:on, fields}, acc)
  end
end
