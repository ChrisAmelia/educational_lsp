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

    result =
      case method do
        "initialize" -> handle_initialize(params, state)
        _other -> {:error, "Method not found"}
      end

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

  defp handle_initialize(_params, _state) do
    # request = LSP.InitializeRequest.from_json(contents)

    # Logger.info(
    #  "Connected to #{request.params.clientInfo.name} (#{request.params.clientInfo.version})"
    # )

    # try do
    #  response = Jason.encode!(InitializeResponse.new_initialize_response(request.id))
    #  Logger.info("Sending to client:")
    #  Logger.info(response)
    #  IO.puts(RPC.encode_message(response))
    # rescue
    #  e -> Logger.warn(inspect(e))
    # end

    %{
      "capabilities" => %{
        "textDocumentSync" => 1,
        "hoverProvider" => true,
        "completionProvider" => %{"resolveProvider" => false}
      }
    }
  end
end
