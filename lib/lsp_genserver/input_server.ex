defmodule EducationalLSP.InputServer do
  use GenServer
  require Logger

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_) do
    Logger.info("InputServer started. Listening on stdin...")
    Process.send_after(self(), :read_input, 0)
    {:ok, nil}
  end

  @impl true
  def handle_info(:read_input, state) do
    case IO.read(:stdio, :line) do
      :eof ->
        Logger.info("EOF received. Shutting down.")
        {:stop, :normal, state}

      {:error, reason} ->
        Logger.error("Error reading input: #{inspect(reason)}")
        Process.send_after(self(), :read_input, 100)
        {:noreply, state}

      message ->
        message = String.trim(message)
        response = "hello " <> message
        IO.puts(response)
        Process.send_after(self(), :read_input, 0)
        {:noreply, state}
    end
  end
end
