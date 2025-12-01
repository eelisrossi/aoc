defmodule Mix.Tasks.Aoc.Gen.Day do
  use Mix.Task

  @shortdoc "Generates a new day solution file"

  @moduledoc """
  Generates a new day solution file from the template.

  ## Usage

      mix aoc.gen.day YEAR DAY

  ## Examples

      mix aoc.gen.day 2025 1
      mix aoc.gen.day 2024 15
  """

  @impl Mix.Task
  def run([year_str, day_str]) do
    year = String.to_integer(year_str)
    day = String.to_integer(day_str)

    if day < 1 or day > 25 do
      Mix.shell().error("Day must be between 1 and 25")
      System.halt(1)
    end

    day_padded = String.pad_leading(day_str, 2, "0")
    module_name = "Aoc.Year#{year}.Day#{day_padded}"
    file_path = "lib/#{year}/day#{day_padded}.ex"

    if File.exists?(file_path) do
      Mix.shell().error("File #{file_path} already exists!")
      System.halt(1)
    end

    File.mkdir_p!("lib/#{year}")

    content = """
    defmodule #{module_name} do
      @moduledoc \"\"\"
      Day #{day}: [Puzzle Title]
      https://adventofcode.com/#{year}/day/#{day}
      \"\"\"

      @doc \"\"\"
      Solves part 1 of the puzzle.
      \"\"\"
      def part1(input) do
        input
        |> parse()
        |> solve_part1()
      end

      @doc \"\"\"
      Solves part 2 of the puzzle.
      \"\"\"
      def part2(input) do
        input
        |> parse()
        |> solve_part2()
      end

      defp parse(input) do
        input
        |> String.trim()
        |> String.split("\\n")
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
        path = Path.join(__DIR__, "day#{day_padded}-test.txt")

        case File.read(path) do
          {:ok, contents} ->
            contents

          {:error, reason} ->
            IO.puts("Could not read file: \#{:file.format_error(reason)}")
            nil
        end
      end

      @doc \"\"\"
      Runs both parts with the actual input for this day.
      \"\"\"
      def run do
        input = Aoc.InputFetcher.get_input(#{year}, #{day})
        
        IO.puts("Day #{day} - Part 1: \#{part1(input)}")
        IO.puts("Day #{day} - Part 2: \#{part2(input)}")
      end
    end
    """

    File.write!(file_path, content)
    Mix.shell().info("Generated #{file_path}")
    Mix.shell().info("Fetch the input with: mix aoc.fetch #{year} #{day}")
  end

  def run(_) do
    Mix.shell().error("Usage: mix aoc.gen.day YEAR DAY")
    System.halt(1)
  end
end
