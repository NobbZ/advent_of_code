defmodule AoC15.Day6 do
  @moduledoc false

  @partition_size 20

  use AoC15.Default

  alias AoC15.Day6.Reader

  @input Reader.read(@input)

  def a(input \\ @input) do
    input
    |> Stream.map(&rewrite_instruction/1)
    |> Enum.reduce(new(), &apply_instructions/2)
    |> Enum.reduce(0, fn {_, s}, sum -> sum + MapSet.size(s) end)
  end

  def b(input \\ @input) do
    input
    |> Stream.map(&rewrite_instruction/1)
    |> Enum.reduce(Map.new, &apply_instructions_b/2)
    |> Map.values
    |> Stream.map(&Map.values/1)
    |> Stream.concat()
    |> Enum.sum
  end

  defp rewrite_instruction({tok, area}), do: {tok, area_to_list(area)}

  defp area_to_list({{x1, y1}, {x2, y2}}), do: for x <- x1..x2, y <- y1..y2, do: {x, y}

  defp apply_instructions({:on,  fields}, acc), do: Enum.reduce(fields, acc, fn (f, set) -> put(set, f) end)
  defp apply_instructions({:off, fields}, acc), do: Enum.reduce(fields, acc, fn (f, set) -> delete(set, f) end)
  defp apply_instructions({:tgl, fields}, acc), do: Enum.reduce(fields, acc, fn (f, set) -> if member?(set, f), do: delete(set, f), else: put(set, f) end)

  defp apply_instructions_b({:on,  fields}, acc), do: Enum.reduce(fields, acc, fn (f, map) -> update(map, f, 1, &(&1 + 1)) end)
  defp apply_instructions_b({:off, fields}, acc), do: Enum.reduce(fields, acc, fn (f, map) -> update(map, f, 0, &(if &1 - 1 <= 0, do: 0, else: &1 - 1)) end)
  defp apply_instructions_b({:tgl, fields}, acc) do
    acc = apply_instructions_b({:on, fields}, acc)
    apply_instructions_b({:on, fields}, acc)
  end

  defp new, do: %{}

  defp put(set, {x, y}) do
    case {div(x, @partition_size), div(y, @partition_size)} do
      {xh, yh} -> Map.update(set, {xh, yh}, MapSet.new([{x, y}]), &MapSet.put(&1, {x, y}))
    end
  end

  defp delete(set, {x, y}) do
    case {div(x, @partition_size), div(y, @partition_size)} do
      {xh, yh} -> Map.update(set, {xh, yh}, MapSet.new([]), &MapSet.delete(&1, {x, y}))
    end
  end

  defp member?(set, {x, y}) do
    case set[{div(x, @partition_size), div(y, @partition_size)}] do
      ms = %MapSet{} -> MapSet.member?(ms, {x, y})
      _ -> false
    end
  end

  defp update(map, {x, y}, init, f) do
    case {div(x, @partition_size), div(y, @partition_size)} do
      {xh, yh} -> Map.update(map, {xh, yh}, %{{x, y} => init}, &Map.update(&1, {x, y}, init, f))
    end
  end
end
