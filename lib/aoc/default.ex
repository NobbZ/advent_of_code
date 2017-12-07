defmodule AoC15.Default do
  defmacro __using__([]) do
    filename = __CALLER__.file |> Path.basename() |> String.replace_suffix(".ex", ".txt")
    file = Path.join(:code.priv_dir(:aoc15), filename)
    quote do
      @external_resource unquote(file)

      Module.put_attribute(__MODULE__, :input, File.read!(unquote(file)))
    end
  end
end
