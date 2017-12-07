defmodule AdventOfCodeTests do

  @testdata [
    {1, [
        a: [
          {"(())", 0}, {"()()", 0}, {"(((", 3}, {"(()(()(", 3}, {"))(((((", 3},
          {"())", -1}, {"))(", -1}, {")))", -3}, {")())())", -3}, {:file, 232}
        ],
        b: [
          {")", 1}, {"()())", 5}, {:file, 1783}
        ]
      ]
    },
    {2, [
        a: [
          {"2x3x4", 58}, {"1x1x10", 43}, {"2x3x4\n1x1x10", 101}, {:file, 1606483}
        ],
        b: [
          {"2x3x4", 34}, {"1x1x10", 14}, {"2x3x4\n1x1x10",  48}, {:file, 3842356}
        ]
      ]},
    {3, [
        a: [
          {">", 2}, {"^>v<", 4}, {"^v^v^v^v^v", 2}, {:file, 2592}
        ],
        b: [
          {"^v", 3}, {"^>v<", 3}, {"^v^v^v^v^v", 11}, {:file, 2360}
        ]
      ]},
    {4, [
        a: [
          {"abcdef", 609043}, {"pqrstuv", 1048970}, {"yzbqklnj", 282749}
        ],
        b: [
          {"abcdef", 6742839}, {"pqrstuv", 5714438}, {"yzbqklnj", 9962624}
        ]
      ]},
    {5, [
        a: [
          {"ugknbfddgicrmopn", 1}, {"aaa", 1}, {"jchzalrnumimnmhp", 0},
          {"haegwjzuvuyypxyu", 0}, {"dvszwmarrgswjxmb", 0}, {:file, 255}
        ],
        b: [
          {"qjhvhtzxzqqjkmpb", 1}, {"xxyxx", 1}, {"uurcxstgmygtbstg", 0},
          {"ieodomkazucvgmuy", 0}, {:file, 55}
        ]
      ]},
    {6, [
        a: [
          {"turn on 0,0 through 999,999", 1_000_000},
          {"turn on 0,0 through 999,999\ntoggle 0,0 through 999,0", 999_000},
          {"turn on 0,0 through 999,999\nturn off 499,499 through 500,500", 999_996},
          {:file, 543903}
        ],
        b: [
          {"turn on 0,0 through 0,0", 1},
          {"toggle 0,0 through 999,999", 2_000_000},
          {:file, 14687245}
        ]
      ]},
    {7, [
        a: [
          {"123 -> a", 123},
          {"65535 -> b\n5 -> c\nb AND c -> a", 5},
          {"65535 -> b\n5 -> c\nb OR c -> a", 65535},
          {"2 -> b\nb LSHIFT 1 -> a", 4},
          {"2 -> b\nb RSHIFT 1 -> a", 1},
          {"65535 -> b\nNOT b -> a", 0},
          {"0 -> b\nNOT b -> a", 65535},
          {"123 -> b\nb -> a", 123},
          {:file, 3176}
        ],
        b: [
          {:file, 14710}
        ]
      ]}
  ]

  @testdata
  |> Enum.each(fn {day, funs} ->
    mod = Module.concat(AoC15, "Day#{day}")
    testmod = Module.concat(AoC15Test, "Day#{day}Test")

    defmodule testmod do
      use ExUnit.Case

      for {fun, tests} <- funs do
        for {input, exp} <- tests do
          {name, input} = case input do
                            :file ->
                              {"#{fun}: from file is #{exp}",
                               File.read!(
                                 Application.app_dir(:aoc15,
                                                     "priv/#{day}.txt"))}
                            _ ->
                              {"#{fun}: example #{input} is #{exp}", input}
                          end
          test name do
            assert unquote(exp) = apply(unquote(mod),
                                        unquote(fun),
                                        [unquote(input)])
          end
        end
      end
    end
  end)
end
