defmodule TrafficLightsServerTest do
  use ExUnit.Case
  doctest TrafficLightsServer

  test "3 signal transition for 5 different pids" do
    {:ok, pids} = TrafficLightsServer.start_link([])
    TrafficLightsServer.transition(pids)
    TrafficLightsServer.transition(pids)
    TrafficLightsServer.transition(pids)
    assert TrafficLightsServer.current_lights(pids) == [:green, :green, :green, :green, :green]
  end

  test "initial :yellow with 1 transition" do
    {:ok, pids} = TrafficLightsServer.start_link([])
    TrafficLightsServer.transition(pids)

    assert TrafficLightsServer.current_lights(pids) == [
             :yellow,
             :yellow,
             :yellow,
             :yellow,
             :yellow
           ]
  end

  test "initail :red 3 transition" do
    {:ok, pids} = TrafficLightsServer.start_link([])
    TrafficLightsServer.transition(pids)
    TrafficLightsServer.transition(pids)
    TrafficLightsServer.transition(pids)
    assert TrafficLightsServer.current_lights(pids) == [:green, :green, :green, :green, :green]
  end
end
