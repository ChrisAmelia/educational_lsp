defmodule EducationalLSP.InputServer do
  @moduledoc """
  A GenServer that reads and processes JSON-RPC 2.0 message from standard input.
  """

  require Logger
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_) do
    Process.send_after(self(), :read_input, 0)
    {:ok, nil}
  end

  @impl true
  def handle_info(:read_input, state) do
    case IO.read(:stdio, :line) do
      :eof ->
        Logger.info("EOF received. Shutting down.")
        System.stop()

      {:error, reason} ->
        Logger.info("Error reading input: #{inspect(reason)}")
        Process.send_after(self(), :read_input, 100)
        {:noreply, state}

      header ->
        content_length =
          header |> String.split(":") |> Enum.at(1) |> String.trim() |> String.to_integer()

        message = IO.binread(content_length + 2)

        case Jason.decode(message) do
          {:ok, json_rpc} ->
            try do
              handle_json_rpc(json_rpc)
            rescue
              e ->
                Logger.error("Error handling JSON-RPC: #{inspect(e)}")
                Logger.error(Exception.format_stacktrace(__STACKTRACE__))
            end

          {:error, reason} ->
            Logger.error("Invalid JSON: #{reason}")
        end

        # Schedule next read AFTER processing
        Process.send_after(self(), :read_input, 0)
        {:noreply, state}
    end
  end

  defp handle_json_rpc(%{"jsonrpc" => "2.0", "method" => method, "params" => params, "id" => id}) do
    result = EducationalLSP.LSPServer.handle_request(method, params)

    response =
      Jason.encode!(%{
        "jsonrpc" => "2.0",
        "id" => id,
        "result" => result
      })

    IO.write(RPC.encode_message(response))
  end

  defp handle_json_rpc(%{"jsonrpc" => "2.0", "method" => method, "params" => params}) do
    EducationalLSP.LSPServer.handle_notification(method, params)
  end

  defp handle_json_rpc(%{"id" => 2, "jsonrpc" => "2.0", "method" => "shutdown"}) do
    Logger.info("Shutdown request from client. Shutting down.")
    System.stop()
  end

  defp handle_json_rpc(other) do
    Logger.debug("DEBUG: No pattern matched. Received:")
    Logger.debug(inspect(other, limit: 10, printable_limit: 100))
  end
end
