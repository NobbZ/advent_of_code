defmodule AdventOfCodeTests do

  @values %{
    1 => [a:     232, b:     1783],
    2 => [a: 1606483, b:  3842356],
    3 => [a:    2592, b:     2360],
    4 => [a:  282749, b:  9962624],
    5 => [a:     255, b:       55],
    6 => [a:  543903, b: 14687245],
    7 => [a:    3176, b:    14710],
  }

  @examples %{
    1 => [{:a, "(())",     0},
          {:a, "()()",     0},
          {:a, "(((",      3},
          {:a, "(()(()(",  3},
          {:a, "))(((((",  3},
          {:a, "())",     -1},
          {:a, "))(",     -1},
          {:a, ")))",     -3},
          {:a, ")())())", -3},
          {:b, ")",        1},
          {:b, "()())",    5}],

    2 => [{:a, "2x3x4",          58},
          {:a, "1x1x10",         43},
          {:a, "2x3x4\n1x1x10", 101},
          {:b, "2x3x4",          34},
          {:b, "1x1x10",         14},
          {:b, "2x3x4\n1x1x10",  48}],

    3 => [{:a, ">",           2},
          {:a, "^>v<",        4},
          {:a, "^v^v^v^v^v",  2},
          {:b, "^v",          3},
          {:b, "^>v<",        3},
          {:b, "^v^v^v^v^v", 11}],

    4 => [{:a, "abcdef",   609043},
          {:a, "pqrstuv", 1048970},
          {:b, "abcdef",  6742839},
          {:b, "pqrstuv", 5714438}],

    5 => [{:a, "ugknbfddgicrmopn", 1},
          {:a, "aaa",              1},
          {:a, "jchzalrnumimnmhp", 0},
          {:a, "haegwjzuvuyypxyu", 0},
          {:a, "dvszwmarrgswjxmb", 0},
          {:b, "qjhvhtzxzqqjkmpb", 1},
          {:b, "xxyxx",            1},
          {:b, "uurcxstgmygtbstg", 0},
          {:b, "ieodomkazucvgmuy", 0}],

    6 => [{:a, [{:on,  {{  0,   0}, {999, 999}}}], 1_000_000},
          {:a, [{:on,  {{  0,   0}, {999, 999}}},
                {:tgl, {{  0,   0}, {999,   0}}}],   999_000},
          {:a, [{:on,  {{  0,   0}, {999, 999}}},
                {:off, {{499, 499}, {500, 500}}}],   999_996},
          {:b, [{:on,  {{  0,   0}, {  0,   0}}}],         1},
          {:b, [{:tgl, {{  0,   0}, {999, 999}}}], 2_000_000}],

    7 => [{:a, "123 -> a",                          123},
          {:a, "65535 -> b\n5 -> c\nb AND c -> a",    5},
          {:a, "65535 -> b\n5 -> c\nb OR c -> a", 65535},
          {:a, "2 -> b\nb LSHIFT 1 -> a",             4},
          {:a, "2 -> b\nb RSHIFT 1 -> a",             1},
          {:a, "65535 -> b\nNOT b -> a",              0},
          {:a, "0 -> b\nNOT b -> a",              65535},
          {:a, "123 -> b\nb -> a",                  123}],
  }

  @examples
  |> Map.merge(@values, fn _, ex, v -> ex ++ v end)
  |> Enum.each(fn {day, tests} ->
    mod = Module.concat(AoC15, "Day#{day}")
    testmod = Module.concat(AoC15Test, "Day#{day}Test")

    defmodule testmod do
      use ExUnit.Case
      Enum.each(tests, fn
        {part, input, expect} ->
          test "Day #{day}#{part}: #{inspect input} is #{expect}", do:
            assert unquote(mod).unquote(part)(unquote(Macro.escape(input))) == unquote(expect)
        {part, expect} ->
          @tag :full
          test "Day #{day}#{part}: **FULL**", do:
            assert unquote(mod).unquote(part)() == unquote(expect)
      end)
    end
  end)
end
