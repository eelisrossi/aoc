# Advent of Code

Solutions for [Advent of Code](https://adventofcode.com) written in Elixir.

## Setup

1. Install dependencies:
```bash
mix deps.get
```

2. Set your Advent of Code session cookie:
```bash
export AOC_SESSION=your_session_cookie_here
```

To get your session cookie:
- Log in to https://adventofcode.com
- Open browser DevTools (F12)
- Go to Application/Storage > Cookies > https://adventofcode.com
- Copy the value of the 'session' cookie

## Usage

### Generate a new day solution

```bash
mix aoc.gen.day 2025 1
```

This creates `lib/2025/day01.ex` with the solution template.

### Fetch input for a day

From IEx:
```elixir
# Fetch and save input to inputs/2025/day01.txt
Aoc.InputFetcher.fetch(2025, 1)

# Force re-download even if file exists
Aoc.InputFetcher.fetch(2025, 1, force: true)

# Get input as string (fetches if not cached)
Aoc.InputFetcher.get_input(2025, 1)
```

### Run a solution

```elixir
# Assuming you've implemented Aoc.Year2025.Day01
Aoc.Year2025.Day01.run()
```

### List all solutions

```elixir
Aoc.list_solutions()
# => [{"2024", 1}, {"2024", 2}, {"2025", 1}, ...]
```

## Project Structure

```
lib/
  2025/
    day01.ex          # Day 1 solution
    day02.ex          # Day 2 solution
    ...
  2024/
    day01.ex          # Previous year's solutions
    ...
  input_fetcher.ex    # Input fetching module
  aoc.ex              # Main module
inputs/
  2025/
    day01.txt         # Cached inputs
    day02.txt
  2024/
    day01.txt
```

