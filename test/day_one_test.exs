defmodule AdventOfCodeTests do

  @testdata [
    {DayOne, [
        a: [
          {"(())", 0}, {"()()", 0}, {"(((", 3}, {"(()(()(", 3}, {"))(((((", 3},
          {"())", -1}, {"))(", -1}, {")))", -3}, {")())())", -3}
        ],
        b: [
          {")", 1}, {"()())", 5},
        ]
      ]
    },
  ]

  for {module, funs} <- @testdata do
    defmodule module do
      use PowerAssert, async: true
      for {fun, tests} <- funs do
        for {input, exp} <- tests do
          name = "#{fun}: example #{input} is #{exp}"
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
