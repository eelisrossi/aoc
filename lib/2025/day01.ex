defmodule Aoc.Year2025.Day01 do
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
  end

  defp solve_part1(data) do
    # TODO: Implement part 1
    data
  end

  defp solve_part2(data) do
    # TODO: Implement part 2
    data
  end

  def get_test_data do
    path = Path.join(__DIR__, "day01-test.txt")

    case File.read(path) do
      {:ok, contents} ->
        contents

      {:error, reason} ->
        IO.puts("Could not read file: #{:file.format_error(reason)}")
        nil
    end
  end

  def run do
    # input = Aoc.InputFetcher.get_input(2025, 1)

    input = get_test_data()

    IO.puts("Day 1 - Part 1: #{part1(input)}")
    IO.puts("Day 1 - Part 2: #{part2(input)}")
  end
end
