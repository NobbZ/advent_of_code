defmodule DayOneATests do
  use PowerAssert, async: true

  @testdata [
    {"(())", 0},
    {"()()", 0},
    {"(((", 3},
    {"(()(()(", 3},
    {"))(((((", 3},
    {"())", -1},
    {"))(", -1},
    {")))", -3},
    {")())())", -3}
  ]

  for {input, exp} <- @testdata do
    name = "example #{input} is #{exp}"
    test name, do: assert unquote(exp) = AdventOfCode.DayOne.a unquote(input)
  end
end

defmodule DayOneBTests do
  use PowerAssert, async: true

  @testdata [
    {")", 1},
    {"()())", 5},
  ]

  for {input, exp} <- @testdata do
    name = "example #{input} is #{exp}"
    test name, do: assert unquote(exp) = AdventOfCode.DayOne.b unquote(input)
  end
end
