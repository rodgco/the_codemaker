defmodule TheCodemaker.Tools.ExtractCalibrationTest do
  use ExUnit.Case
  alias TheCodemaker.Tools.ExtractCalibration

  test "parse" do
    assert ExtractCalibration.parse("1abc2", mode: :digits_only) == 12
    assert ExtractCalibration.parse("pqr3stu8vwx", mode: :digits_only) == 38
    assert ExtractCalibration.parse("a1b2c3d4e5f", mode: :digits_only) == 15
    assert ExtractCalibration.parse("treb7uchet", mode: :digits_only) == 77
    assert ExtractCalibration.parse("two1nine", mode: :digits_and_text) == 29
    assert ExtractCalibration.parse("eightwothree", mode: :digits_and_text) == 83
    assert ExtractCalibration.parse("abcone2threexyz", mode: :digits_and_text) == 13
    assert ExtractCalibration.parse("xtwone3four", mode: :digits_and_text) == 24
    assert ExtractCalibration.parse("4nineeightseven2", mode: :digits_and_text) == 42
    assert ExtractCalibration.parse("zoneight234", mode: :digits_and_text) == 14
    assert ExtractCalibration.parse("7pqrstsixteen", mode: :digits_and_text) == 76
    assert ExtractCalibration.parse("7pqrstsixteen", mode: :text_only) == 66
    assert ExtractCalibration.parse("two1nine", mode: :text_only) == 29
    assert ExtractCalibration.parse("eightwothree", mode: :text_only) == 83
    assert ExtractCalibration.parse("abc2onethreexyz", mode: :text_only) == 13
    assert ExtractCalibration.parse("xtwone3zero", mode: :text_only) == 20

    assert_raise RuntimeError, "Invalid number", fn ->
      ExtractCalibration.parse("1234", mode: :text_only)
    end

    assert_raise RuntimeError, "Invalid number", fn ->
      ExtractCalibration.parse("one", mode: :digits_only)
    end

    assert_raise RuntimeError, "Invalid number", fn ->
      ExtractCalibration.parse("qwerty", mode: :digits_and_text)
    end
  end
end
