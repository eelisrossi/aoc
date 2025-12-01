defmodule AocTest do
  use ExUnit.Case
  doctest Aoc

  test "lists solutions" do
    solutions = Aoc.list_solutions()
    assert is_list(solutions)
  end
end
