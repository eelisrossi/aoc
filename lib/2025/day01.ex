defmodule Aoc.Year2025.Day01 do
  @moduledoc """
  Day 1: [Secret Entrance]
  https://adventofcode.com/2025/day/1
  """

  @doc """
  Solves part 1 of the puzzle.
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @doc """
  Solves part 2 of the puzzle.
  """
  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end

  defp solve_part1(data) do
    # TODO: Implement part 1
    data
  end

  defp solve_part2(data) do
    # TODO: Implement part 2
    data
  end

  @doc """
  Runs both parts with the actual input for this day.
  """
  def run do
    input = Aoc.InputFetcher.get_input(2025, 1)

    IO.puts("Day 1 - Part 1: #{part1(input)}")
    IO.puts("Day 1 - Part 2: #{part2(input)}")
  end
end
