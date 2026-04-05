defmodule EducationalLSP.LSPServer do
  require Logger
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_) do
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

  @impl true
  def handle_call({:request, method, params}, _from, state) do
    Logger.info("request: [#{method}]")
    Logger.info(inspect(params))

    result = LSP.MethodHandlers.handle_method(method, params)

    {:reply, result, state}
  end

  @impl true
  def handle_cast({:notification, method, params}, state) do
    Logger.info("notification: [#{method}]")
    Logger.info(inspect(params))

    new_state =
      case method do
        _other -> state
      end

    {:noreply, new_state}
  end
end
