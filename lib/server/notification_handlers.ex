defmodule LSP.NotificationHandlers do
  @doc """
  Dispatches to the appropriate function for the given `method`.
  """
  @spec handle_method(String.t(), term()) :: atom()
  def handle_method(method, params) do
    case method do
      "initialized" -> handle_initialized(params)
      _other -> :ok
    end
  end

  @spec handle_initialized(term()) :: atom()
  defp handle_initialized(_params), do: :initialized
end
