defmodule DbConnectTest do
  use ExUnit.Case
  doctest DbConnect

  test "greets the world" do
    assert DbConnect.hello() == :world
  end
end
