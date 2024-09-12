defmodule TheCodemaker.AdventOfCode do
  use HTTPoison.Base
  alias TheCodemaker.AdventOfCode.Date, as: AOCDate

  @impl true
  def process_request_url(url) do
    "https://adventofcode.com#{url}" |> IO.inspect()
  end

  @impl true
  def process_request_headers(headers) do
    Keyword.merge(
      [
        Origin: "https://adventofcode.com",
        Cookie: "session=#{System.get_env("AOC_SESSION")}"
      ],
      headers
    )
  end

  @impl true
  def process_response(response) do
    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        {:ok, body}

      %HTTPoison.Response{status_code: 400} ->
        {:error, "Please insert your key"}

      %HTTPoison.Response{status_code: 404} ->
        {:error, "Not found :("}

      %HTTPoison.Response{status_code: 500} ->
        {:error, "Server error :("}

      %HTTPoison.Error{reason: reason} ->
        {:error, reason}
    end
  end

  def get_input(day), do: get_input(AOCDate.default_year(), day)

  def get_input(year, day) do
    url = "/#{year}/day/#{day}/input"

    headers = [
      Referer: "https://adventofcode.com/#{year}/day/#{day}"
    ]

    get!(url, headers, [])
  end

  def submit_answer(day, level, answer),
    do: submit_answer(AOCDate.default_year(), day, level, answer)

  def submit_answer(year, day, level, answer) do
    url = "/#{year}/day/#{day}/answer"

    headers = [
      Referer: "https://adventofcode.com/#{year}/day/#{day}",
      "Content-Type": "application/x-www-form-urlencoded"
    ]

    payload = "level=#{level}&answer=#{answer}"
    # payload = %{ form: [level: level, answer: answer] }

    post!(url, payload, headers)
    |> process_submit_response()
    |> IO.inspect(label: "submit_answer")
  end

  defp process_submit_response({:ok, body}) do
    cond do
      body =~ ~r/That's the right answer!/ ->
        {:ok, "Correct!"}

      body =~ ~r/That's not the right answer; your answer is too high/ ->
        {:error, "Too high!"}

      body =~ ~r/That's not the right answer; your answer is too low/ ->
        {:error, "Too low!"}

      body =~ ~r/You gave an answer too recently;/ ->
        {:error, "Too soon!"}

      body =~ ~r/You don\'t seem to be solving the right level/ ->
        {:error, "Wrong level!"}

      true ->
        IO.inspect(Floki.find(body, "article>p"), label: "Uknown error")
        {:error, "Unknown error"}
    end
  end

  defp process_submit_response({:error, reason}) do
    {:error, reason}
  end
end
