defmodule TheCodemaker.Tools.ExtractCalibration do
  @doc """
  Parse the text and return a combination of the first and last number found.
  """
  @spec parse(String.t(), mode: :digits_only | :digits_and_text | :text_only) :: integer
  def parse(text, options) do
    [mode: mode] = options

    matcher =
      case mode do
        :digits_only -> "[0-9]"
        :digits_and_text -> "[0-9]|zero|one|two|three|four|five|six|seven|eight|nine"
        :text_only -> "zero|one|two|three|four|five|six|seven|eight|nine"
      end

    first =
      Regex.run(~r/^.*?(#{matcher})/, text, capture: :all_but_first)
      # If there is no match, the previous line returns nil
      |> Kernel.||([nil])
      |> hd
      |> parse_number

    last =
      Regex.run(~r/^.*(#{matcher}).*?$/, text, capture: :all_but_first)
      |> hd
      |> parse_number

    first * 10 + last
  end

  defp parse_number(text) when text in ~w(1 one), do: 1
  defp parse_number(text) when text in ~w(2 two), do: 2
  defp parse_number(text) when text in ~w(3 three), do: 3
  defp parse_number(text) when text in ~w(4 four), do: 4
  defp parse_number(text) when text in ~w(5 five), do: 5
  defp parse_number(text) when text in ~w(6 six), do: 6
  defp parse_number(text) when text in ~w(7 seven), do: 7
  defp parse_number(text) when text in ~w(8 eight), do: 8
  defp parse_number(text) when text in ~w(9 nine), do: 9
  defp parse_number(text) when text in ~w(0 zero), do: 0
  defp parse_number(_), do: raise("Invalid number")
end
