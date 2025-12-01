defmodule Mix.Tasks.Aoc.Fetch do
  use Mix.Task

  @shortdoc "Fetches Advent of Code input for a specific day"

  @moduledoc """
  Fetches the puzzle input for a given day and year from adventofcode.com.

  Requires AOC_SESSION to be set (either in .env file or as environment variable).

  ## Usage

      mix aoc.fetch YEAR DAY [--force]

  ## Examples

      mix aoc.fetch 2025 1
      mix aoc.fetch 2024 15
      mix aoc.fetch 2025 1 --force    # Re-fetch even if cached

  """

  @impl Mix.Task
  def run(args) do
    {opts, args, _} = OptionParser.parse(args, strict: [force: :boolean])
    
    case args do
      [year_str, day_str] ->
        year = String.to_integer(year_str)
        day = String.to_integer(day_str)

        if day < 1 or day > 25 do
          Mix.shell().error("Day must be between 1 and 25")
          System.halt(1)
        end

        # Start applications needed for HTTP requests
        Mix.Task.run("app.start")

        force = Keyword.get(opts, :force, false)
        
        case Aoc.InputFetcher.fetch(year, day, force: force) do
          {:ok, path} ->
            Mix.shell().info("✓ Input fetched successfully: #{path}")
            
          {:error, reason} ->
            Mix.shell().error("✗ Failed to fetch input: #{reason}")
            System.halt(1)
        end

      _ ->
        Mix.shell().error("Usage: mix aoc.fetch YEAR DAY [--force]")
        System.halt(1)
    end
  end
end
