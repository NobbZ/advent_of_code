defmodule DayOneATests do
  use PowerAssert, async: true

  test "example (()) is 0", do: assert 0 == AdventOfCode.DayOne.a "(())"
  test "example ()() is 0", do: assert 0 == AdventOfCode.DayOne.a "()()"
  test "example ((( is 3", do: assert 3 == AdventOfCode.DayOne.a "((("
  test "example (()(()( is 3", do: assert 3 == AdventOfCode.DayOne.a "(()(()("
  test "example ))((((( is 3", do: assert 3 == AdventOfCode.DayOne.a "))((((("
  test "example ()) is -1", do: assert -1 == AdventOfCode.DayOne.a "())"
  test "example ))( is -1", do: assert -1 == AdventOfCode.DayOne.a "))("
  test "example ))) is -3", do: assert -3 == AdventOfCode.DayOne.a ")))"
  test "example )())()) is -3", do: assert -3 == AdventOfCode.DayOne.a ")())())"
end

defmodule DayOneBTests do
  use PowerAssert, async: true

  test "example ) is 1", do: assert 1 == AdventOfCode.DayOne.b ")"
  test "example ()()) is 5", do: assert 5 == AdventOfCode.DayOne.b "()())"
end
