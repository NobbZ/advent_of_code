defmodule AoC15.Day7 do
  use Bitwise

  @mod_cap 65536

  def a(input) do
    input
    |> String.strip
    |> String.split("\n")
    |> Stream.map(&String.split(&1, " -> "))
    |> Stream.map(&parse/1)
    |> Enum.into([])
    |> eval_each_item(%{}, [])
    |> (fn map -> map["a"] end).()
  end

  def b(input) do
    instrs = input
    |> String.strip
    |> String.split("\n")
    |> Stream.map(&String.split(&1, " -> "))
    |> Stream.map(&parse/1)
    |> Enum.into([])

    context = instrs
    |> eval_each_item(%{}, [])
    |> (fn map -> %{map | "b" => map["a"]} end).()
    |> Enum.filter(fn {"b", _} -> true
      _ -> false end)
    |> Enum.into(%{})

    instrs
    |> Enum.filter(fn {"b", _} -> false
      _ -> true end)
    |> eval_each_item(context, [])
    |> (fn map -> map["a"] end).()
  end

  defp parse([instr, pin]), do: {pin, parse_instr(instr)}

  defp parse_instr(instr_str) when is_binary(instr_str), do: instr_str |> String.split |> parse_instr
  defp parse_instr([x, "AND", y]), do: {:and, parse_instr([x]), parse_instr([y])}
  defp parse_instr([x, "OR", y]), do: {:or, parse_instr([x]), parse_instr([y])}
  defp parse_instr([x, "LSHIFT", y]), do: {:lshift, parse_instr([x]), parse_instr([y])}
  defp parse_instr([x, "RSHIFT", y]), do: {:rshift, parse_instr([x]), parse_instr([y])}
  defp parse_instr(["NOT", x]), do: {:not, parse_instr([x])}
  defp parse_instr([thing]) do
    case Integer.parse(thing) do
      {num, ""} -> {:num, num}
      :error -> {:pin, thing}
      x -> IO.inspect x
    end
  end

  defp eval_each_item([], acc, []), do: acc
  defp eval_each_item([], acc, [_|_] = stack), do: eval_each_item(stack, acc, [])
  defp eval_each_item([{pin, inst}|t], acc, stack) do
    case eval_partial(inst, acc) do
      {:num, n} -> eval_each_item(t, Map.put(acc, pin, n), stack)
      thing -> eval_each_item(t, acc, [{pin, thing}|stack])
    end
  end

  defp eval_partial(inst, ctx)
  defp eval_partial({:num, n}, _ctx), do: {:num, n}
  defp eval_partial({:and, {:num, n1}, {:num, n2}}, _ctx), do: overflow(n1 &&& n2)
  defp eval_partial({:or, {:num, n1}, {:num, n2}}, _ctx), do: overflow(n1 ||| n2)
  defp eval_partial({:lshift, {:num, n1}, {:num, n2}}, _ctx), do: overflow(n1 <<< n2)
  defp eval_partial({:rshift, {:num, n1}, {:num, n2}}, _ctx), do: overflow(n1 >>> n2)
  defp eval_partial({:not, {:num, n}}, _ctx), do: overflow(~~~n)
  defp eval_partial({:pin, p}, ctx), do: eval_partial(p, ctx)
  defp eval_partial({:and, v1, v2}, ctx), do: {:and,
                                               eval_partial(v1, ctx),
                                               eval_partial(v2, ctx)}
  defp eval_partial({:or, v1, v2}, ctx), do: {:or,
                                              eval_partial(v1, ctx),
                                              eval_partial(v2, ctx)}
  defp eval_partial({:lshift, v1, v2}, ctx), do: {:lshift,
                                                  eval_partial(v1, ctx),
                                                  eval_partial(v2, ctx)}
  defp eval_partial({:rshift, v1, v2}, ctx), do: {:rshift,
                                                  eval_partial(v1, ctx),
                                                  eval_partial(v2, ctx)}
  defp eval_partial({:not, v}, ctx), do: {:not, eval_partial(v, ctx)}
  defp eval_partial(pin, ctx) when is_binary(pin) do
    case Map.fetch(ctx, pin) do
      {:ok, val} -> {:num, val}
      _ -> {:pin, pin}
    end
  end

  defp overflow(val), do: {:num, mod(val, @mod_cap)}

  defp mod(x, y) when x >= 0, do: rem(x, y)
  defp mod(x, y) when x < 0, do: rem(y + rem(x, y), y)
end
