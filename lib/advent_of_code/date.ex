defmodule TheCodemaker.AdventOfCode.Date do
  @moduledoc """
  Solve the finding the default current year and day for the Advent of Code.
  """

  @key_month 9
  @key_day 25

  @doc """
  Get the current year for the Advent of Code.

  In December, when a new challenge is running, the year is the current year. Otherwise, it is the previous year.
  """
  @spec default_year() :: integer
  def default_year do
    # if it is december return the current calendar year, otherwise return the previous year
    case Date.utc_today() do
      %Date{month: @key_month, year: year} -> year
      %Date{year: year} -> year - 1
    end
  end

  @doc """
  Get the current day for the Advent of Code.

  In December, when a new challenge is running, the day is the current day. Otherwise, it will return nil.
  """
  @spec default_day() :: integer | nil
  def default_day do
    # if it is december return the current calendar day, otherwise return nil
    case Date.utc_today() do
      %Date{month: @key_month, day: day} -> day
      _ -> nil
    end
  end

  @doc """
  Return true if we're during the Advent of Code challenge, otherwise false.
  """
  @spec is_advent_of_code() :: boolean
  def is_advent_of_code do
    # if it is december return true, otherwise return false
    case Date.utc_today() do
      %Date{month: month, day: day} when month == @key_month and day <= @key_day -> true
      _ -> false
    end
  end

  @doc """
  If we're during the Advent of Code challenge, return the current year and day, otherwise return nil.
  """
  @spec today() :: {integer, integer} | nil
  def today do
    # if it is december return the current calendar year and day, otherwise return nil
    case Date.utc_today() do
      %Date{month: @key_month, year: year, day: day} when day <= @key_day -> {year, day}
      _ -> nil
    end
  end
end
