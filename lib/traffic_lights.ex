defmodule TrafficLights do
  @moduledoc """
  Documentation for `TrafficLights`.
  """
  use GenServer

  def start_link(args \\ :green) do
    GenServer.start_link(__MODULE__, args)
  end

  def transition(pid) do
    GenServer.cast(pid, :transition)
  end

  def current_light(pid) do
    GenServer.call(pid, :current_light)
  end

  @impl GenServer
  def init(args) do
    {:ok, args}
  end

  @impl GenServer
  def handle_cast(:transition, state) do
    state =
      case state do
        :green -> :yellow
        :yellow -> :red
        :red -> :green
      end

    {:noreply, state}
  end

  @impl GenServer
  def handle_call(:current_light, _from, state) do
    {:reply, state, state}
  end
end
