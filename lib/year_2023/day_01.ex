defmodule TheCodemaker.Year2023.Day01 do
  alias TheCodemaker.Tools.ExtractCalibration

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&ExtractCalibration.parse(&1, mode: :digits_only))
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&ExtractCalibration.parse(&1, mode: :digits_and_text))
    |> Enum.sum()
  end
end
