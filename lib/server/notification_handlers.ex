defmodule LSP.NotificationHandlers do
  require Logger

  @doc """
  Dispatches to the appropriate function for the given `method`.
  """
  @spec handle_method(String.t(), term(), atom()) :: atom()
  def handle_method(method, params, state) do
    case method do
      "initialized" -> handle_initialized(params)
      "textDocument/didOpen" -> handle_did_open(params)
      _other -> unknown(method, params, state)
    end
  end

  @spec handle_initialized(term()) :: atom()
  defp handle_initialized(_params), do: :noreply

  @spec handle_did_open(term()) :: atom()
  defp handle_did_open(params) do
    Logger.debug("notification [textDocument/didOpen]")
    Logger.debug(Jason.encode!(params))

    State.open_document(params["textDocument"]["uri"], params["textDocument"]["text"])

    :noreply
  end

  @spec unknown(String.t(), term(), atom()) :: term()
  defp unknown(method, params, state) do
    Logger.info("notification [#{method}] not handled")
    Logger.info(Jason.encode!(params))

    state
  end
end
