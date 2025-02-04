defmodule TrafficLightsServer do
  @moduledoc """
  This is meant to handle 5 different TrackLight GenServers
  """
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  def transition(pid_grid) do
    GenServer.cast(pid_grid, :transition)
  end

  def current_lights(pid_grid) do
    GenServer.call(pid_grid, :current_lights)
  end

  def init(_args) do
    pid_grid =
      Enum.map(1..5, fn _ ->
        {:ok, pid} = TrafficLights.start_link()
        pid
      end)

    {:ok, pid_grid}
  end

  def handle_cast(:transition, state) do
    Enum.map(state, fn pid ->
      TrafficLights.transition(pid)
    end)

    {:noreply, state}
  end

  def handle_call(:current_lights, _from, state) do
    lights =
      Enum.map(state, fn pid ->
        TrafficLights.current_light(pid)
      end)

    {:reply, lights, state}
  end
end
