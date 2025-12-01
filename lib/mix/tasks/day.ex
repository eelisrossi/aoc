defmodule Mix.Tasks.Day do
  use Mix.Task

  def run([year_str, day_str]) do
    # Generate the day file
    Mix.Task.run("aoc.gen.day", [year_str, day_str])

    # Fetch the input
    Mix.Task.run("aoc.fetch", [year_str, day_str])
  end
end
