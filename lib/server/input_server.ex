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
        {:stop, :normal, state}

      {:error, reason} ->
        Logger.info("Error reading input: #{inspect(reason)}")
        Process.send_after(self(), :read_input, 100)
        {:noreply, state}

      header ->
        content_length =
          header |> String.split(":") |> Enum.at(1) |> String.trim() |> String.to_integer()

        message = IO.binread(content_length + 2)

        case Jason.decode(message) do
          {:ok, json_rpc} -> handle_json_rpc(json_rpc)
          {:error, _} -> Logger.error("Invalid JSON: #{message}")
        end
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
    Process.send_after(self(), :read_input, 0)
  end

  defp handle_json_rpc(_) do
    :ok
  end
end
