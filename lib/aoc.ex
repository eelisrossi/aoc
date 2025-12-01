defmodule Aoc do
  @moduledoc """
  Advent of Code solutions across multiple years.
  """

  @doc """
  Lists all available solutions.
  """
  def list_solutions do
    Path.wildcard("lib/*/day*.ex")
    |> Enum.map(fn path ->
      [_, year, file] = String.split(path, "/")
      day = String.replace(file, ~r/day(\d+)\.ex/, "\\1")
      {year, String.to_integer(day)}
    end)
    |> Enum.sort()
  end
end
