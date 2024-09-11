defmodule TheCodemaker.AdventOfCode do
  use HTTPoison.Base

  @impl true
  def process_request_url(url) do
    "https://adventofcode.com#{url}" |> IO.inspect()
  end

  @impl true
  def process_response(response) when response.request.method == :post do
    IO.inspect(response, label: "Response")
  end

  def process_response(response), do: response

  def submit_answer(year, day, level, answer) do
    url = "/#{year}/day/#{day}/answer"

    headers = [
      Origin: "https://adventofcode.com",
      Referer: "https://adventofcode.com/#{year}/day/#{day}",
      "Content-Type": "application/x-www-form-urlencoded",
      Cookie: "session=#{System.get_env("AOC_SESSION")}"
    ]

    payload = "level=#{level}&answer=#{answer}"

    case post(url, payload, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found :("}

      {:ok, %HTTPoison.Response{status_code: 500}} ->
        {:error, "Server error :("}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def get_input(year, day) do
    url = "/#{year}/day/#{day}/input"

    headers = [
      {"Cookie", "session=#{System.get_env("AOC_SESSION")}"}
    ]

    case get(url, headers, []) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found :("}

      {:ok, %HTTPoison.Response{status_code: 500}} ->
        {:error, "Server error :("}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
