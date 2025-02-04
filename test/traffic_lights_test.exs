defmodule TrafficLightsTest do
  use ExUnit.Case
  doctest TrafficLights

  test "3 signal transition" do
    {:ok, pid} = TrafficLights.start_link(:green)
    TrafficLights.transition(pid)
    TrafficLights.transition(pid)
    TrafficLights.transition(pid)
    assert TrafficLights.current_light(pid) == :green
  end

  test "initial :yellow with 1 transition" do
    {:ok, pid} = TrafficLights.start_link(:yellow)
    TrafficLights.transition(pid)
    assert TrafficLights.current_light(pid) == :red
  end

  test "initail :red 3 transition" do
    {:ok, pid} = TrafficLights.start_link(:red)
    TrafficLights.transition(pid)
    TrafficLights.transition(pid)
    TrafficLights.transition(pid)
    assert TrafficLights.current_light(pid) == :red
  end
end
