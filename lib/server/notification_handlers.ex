defmodule LSP.NotificationHandlers do
  require Logger

  @doc """
  Dispatches to the appropriate function for the given `method`.
  """
  @spec handle_method(String.t(), term(), atom()) :: atom()
  def handle_method(method, params, state) do
    case method do
      "initialized" -> handle_initialized(params)
      _other -> unknown(method, params, state)
    end
  end

  @spec handle_initialized(term()) :: atom()
  defp handle_initialized(_params), do: :initialized

  @spec unknown(String.t(), term(), atom()) :: term()
  defp unknown(method, params, state) do
    Logger.info("notification [#{method}] not handled")
    Logger.info(Jason.encode!(params))

    state
  end
end
