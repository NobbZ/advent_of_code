defmodule Mix.Tasks.DayOneA do
  use Mix.Task

  @shortdoc "Run Day One A"

  def run [] do
    {:ok, str} = File.read Application.app_dir :advent_of_code, "priv/day_one_input.txt"
    str
    |> String.strip
    |> AdventOfCode.DayOne.a
    |> IO.inspect
  end
end

defmodule Mix.Tasks.DayOneB do
  use Mix.Task

  @shortdoc "Run Day One B"

  def run [] do
    {:ok, str} = File.read Application.app_dir :advent_of_code, "priv/day_one_input.txt"
    str
    |> String.strip
    |> AdventOfCode.DayOne.b
    |> IO.inspect
  end
end
