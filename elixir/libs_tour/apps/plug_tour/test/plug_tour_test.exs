defmodule PlugTourTest do
  use ExUnit.Case
  doctest PlugTour

  test "greets the world" do
    assert PlugTour.hello() == :world
  end
end
