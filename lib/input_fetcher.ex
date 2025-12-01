defmodule Aoc.InputFetcher do
  @moduledoc """
  Fetches Advent of Code input for a given day and year.
  
  Requires a session cookie from adventofcode.com to authenticate.
  Set the AOC_SESSION environment variable with your session cookie.
  
  To get your session cookie:
  1. Log in to https://adventofcode.com
  2. Open browser DevTools (F12)
  3. Go to Application/Storage > Cookies > https://adventofcode.com
  4. Copy the value of the 'session' cookie
  5. Add it to .env file: AOC_SESSION=your_cookie_value
     (or set as environment variable: export AOC_SESSION=your_cookie_value)
  """

  @base_url "https://adventofcode.com"

  # Load .env file if it exists
  Dotenvy.source!([".env", System.get_env()])

  @doc """
  Fetches the input for a given day and year, saving it to a file.
  
  ## Examples
  
      iex> Aoc.InputFetcher.fetch(2025, 1)
      {:ok, "inputs/2025/day01.txt"}
      
      iex> Aoc.InputFetcher.fetch(2025, 1, force: true)
      {:ok, "inputs/2025/day01.txt"}
  """
  def fetch(year, day, opts \\ []) when day in 1..25 do
    session_cookie = get_session_cookie()
    
    if is_nil(session_cookie) do
      {:error, "AOC_SESSION environment variable not set. Please set your session cookie."}
    else
      fetch_input(year, day, session_cookie, opts)
    end
  end

  @doc """
  Gets the input for a given day and year as a string.
  Returns the cached version if available, otherwise fetches from the web.
  """
  def get_input(year, day) when day in 1..25 do
    input_file = input_path(year, day)
    
    if File.exists?(input_file) do
      File.read!(input_file)
    else
      case fetch(year, day) do
        {:ok, _path} -> File.read!(input_file)
        {:error, reason} -> raise "Failed to fetch input: #{reason}"
      end
    end
  end

  defp fetch_input(year, day, session_cookie, opts) do
    input_file = input_path(year, day)
    force = Keyword.get(opts, :force, false)

    if File.exists?(input_file) and not force do
      {:ok, input_file}
    else
      url = "#{@base_url}/#{year}/day/#{day}/input"
      headers = [{"Cookie", "session=#{session_cookie}"}]

      case HTTPoison.get(url, headers) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          File.mkdir_p!("lib/#{year}")
          File.write!(input_file, body)
          {:ok, input_file}

        {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
          {:error, "HTTP #{status_code}: #{body}"}

        {:error, %HTTPoison.Error{reason: reason}} ->
          {:error, "Request failed: #{reason}"}
      end
    end
  end

  defp get_session_cookie do
    System.get_env("AOC_SESSION")
  end

  defp input_path(year, day) do
    "lib/#{year}/day#{String.pad_leading(Integer.to_string(day), 2, "0")}.txt"
  end
end
