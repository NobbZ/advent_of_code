defmodule AdventOfCodeTests do

  @testdata [
    {DayOne, [
        a: [
          {"(())", 0}, {"()()", 0}, {"(((", 3}, {"(()(()(", 3}, {"))(((((", 3},
          {"())", -1}, {"))(", -1}, {")))", -3}, {")())())", -3}, {:file, 232}
        ],
        b: [
          {")", 1}, {"()())", 5}, {:file, 1783}
        ]
      ]
    },
    {DayTwo, [
        a: [
          {"2x3x4", 58}, {"1x1x10", 43}, {"2x3x4\n1x1x10", 101}, {:file, 1606483}
        ],
        b: [
          {"2x3x4", 34}, {"1x1x10", 14}, {"2x3x4\n1x1x10",  48}, {:file, 3842356}
        ]
      ]},
    {DayThree, [
        a: [
          {">", 2}, {"^>v<", 4}, {"^v^v^v^v^v", 2}, {:file, 2592}
        ],
        b: [
          {"^v", 3}, {"^>v<", 3}, {"^v^v^v^v^v", 11}, {:file, 2360}
        ]
      ]}
  ]

  for {module, funs} <- @testdata do
    defmodule module do
      use PowerAssert, async: true
      for {fun, tests} <- funs do
        for {input, exp} <- tests do
          {name, input} = case input do
                            :file ->
                              {"#{fun}: from file is #{exp}",
                               File.read!(
                                 Application.app_dir(:advent_of_code,
                                                     "priv/#{module}.txt"))}
                            _ ->
                              {"#{fun}: example #{input} is #{exp}", input}
                          end
          test name do
            assert unquote(exp) = apply(AdventOfCode.unquote(module),
                                        unquote(fun),
                                        [unquote(input)])
          end
        end
      end
    end
  end
end
