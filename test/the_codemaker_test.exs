defmodule TheCodemakerTest do
  use ExUnit.Case
  doctest TheCodemaker

  test "greets the world" do
    assert TheCodemaker.hello() == :world
  end
end
