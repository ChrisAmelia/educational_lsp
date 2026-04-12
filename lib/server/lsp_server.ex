defmodule EducationalLSP.LSPServer do
  @moduledoc """
  The main GenServer for the LSP implementation.
  """

  require Logger
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_) do
    State.new_state()

    Logger.info("LSP Server initialized")
    {:ok, %{client_pid: nil, state: :initializing}}
  end

  @doc """
  From LSP specification,
  every processed request must send a response back to the sender of the request.

  ## Parameters

    - `method`: the method to be invoked.
    - `params`: the method's params.
  """
  @spec handle_request(String.t(), map()) :: term()
  def handle_request(method, params) do
    GenServer.call(__MODULE__, {:request, method, params})
  end

  @doc """
  From LSP specification,
  a processed notification message must not send a response back. They work like events.

  ## Parameters

    - `method`: the method to be invoked.
    - `params`: the method's params.
  """
  @spec handle_notification(String.t(), map()) :: :ok
  def handle_notification(method, params) do
    GenServer.cast(__MODULE__, {:notification, method, params})
  end

  @doc """
  Sends a notification to the client.

  ## Parameters

    - `method`: the method to be invoked.
    - `params`: the method's params.
  """
  def send_notification_to_client(method, params) do
    GenServer.cast(__MODULE__, {:send_notification, method, params})
  end

  @impl true
  def handle_call({:request, method, params}, _from, state) do
    result = LSP.RequestHandlers.handle_method(method, params)

    {:reply, result, state}
  end

  @impl true
  def handle_cast({:notification, method, params}, state) do
    new_state = LSP.NotificationHandlers.handle_method(method, params, state)

    {:noreply, new_state}
  end

  @impl true
  def handle_cast({:send_notification, method, params}, state) do
    response = %{
      "jsonrpc" => "2.0",
      "method" => method,
      "params" => params
    }

    message = Jason.encode!(response)
    IO.puts(RPC.encode_message(message))

    {:noreply, state}
  end
end
