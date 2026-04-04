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

  def handle_request(method, params) do
    GenServer.call(__MODULE__, {:request, method, params})
  end

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
