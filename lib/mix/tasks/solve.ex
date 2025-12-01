defmodule Mix.Tasks.Solve do
  use Mix.Task

  @shortdoc "Runs the solution for a specific Advent of Code day"

  @moduledoc """
  Runs the solution for a specific Advent of Code day.

  ## Usage

      mix solve [YEAR] [DAY] [OPTIONS]

  If YEAR is not provided, defaults to current year.
  If DAY is not provided, defaults to current day.

  ## Options

      -t, --test    Use test input instead of actual input

  ## Examples

      mix solve 2025 1
      mix solve 2024 15
      mix solve          # Uses current year and day
      mix solve 2025     # Uses 2025 and current day
      mix solve -t       # Uses current year/day with test input
      mix solve 2025 1 -t
  """

  def run(args) do
    Mix.Task.run("app.start")

    {opts, args, _} = OptionParser.parse(args, 
      switches: [test: :boolean],
      aliases: [t: :test]
    )

    use_test = Keyword.get(opts, :test, false)

    {year, day} = case args do
      [year_str, day_str] ->
        {String.to_integer(year_str), String.to_integer(day_str)}
      [year_str] ->
        {String.to_integer(year_str), get_current_day()}
      [] ->
        {get_current_year(), get_current_day()}
    end

    day_str = String.pad_leading(Integer.to_string(day), 2, "0")
    module_name = Module.concat([Aoc, "Year#{year}", "Day#{day_str}"])

    case Code.ensure_loaded(module_name) do
      {:module, _} ->
        if use_test do
          run_with_test_input(module_name, year, day)
        else
          apply(module_name, :run, [])
        end

      {:error, _} ->
        IO.puts("Error: Solution not found for year #{year}, day #{day}")
        IO.puts("Expected module: #{inspect(module_name)}")
        System.halt(1)
    end
  end

  defp get_current_year do
    DateTime.utc_now().year
  end

  defp get_current_day do
    DateTime.utc_now().day
  end

  defp run_with_test_input(module_name, _year, day) do
    if function_exported?(module_name, :get_test_data, 0) do
      input = apply(module_name, :get_test_data, [])
      if input do
        IO.puts("Day #{day} - Part 1: #{apply(module_name, :part1, [input])}")
        IO.puts("Day #{day} - Part 2: #{apply(module_name, :part2, [input])}")
      else
        IO.puts("Error: Could not load test data")
        System.halt(1)
      end
    else
      IO.puts("Error: Test data function not available for this module")
      IO.puts("Make sure the module has a get_test_data/0 function")
      System.halt(1)
    end
  end
end
