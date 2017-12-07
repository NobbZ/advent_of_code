defmodule AoC15.Day4 do
  @input "yzbqklnj"

  def a(input \\ @input) do
    input
    |> gen_hashes
    |> Stream.filter(&five_leading/1)
    |> extract_solution
  end

  def b(input \\ @input) do
    input
    |> gen_hashes
    |> Stream.filter(&six_leading/1)
    |> extract_solution
  end

  defp gen_hashes(input) do
    numbers()
    |> Stream.map(fn n -> {input <> to_string(n), n} end)
    |> Stream.map(fn {str, n} -> {:erlang.md5(str), n} end)
  end

  defp extract_solution(stream) do
    stream
    |> Enum.take(1)
    |> hd
    |> elem(1)
  end

  defp numbers do
    Stream.resource(fn -> 0 end,
      fn (num) -> {[num + 1], num + 1} end,
      fn (num) -> num end)
  end

  defp five_leading({<<0 :: size(20), _ :: size(108)>>, _}), do: true
  defp five_leading(_), do: false

  defp six_leading({<<0 :: size(24), _ :: size(104)>>, _}), do: true
  defp six_leading(_), do: false

end
