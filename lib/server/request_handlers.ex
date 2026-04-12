defmodule LSP.RequestHandlers do
  @moduledoc """
  Handles the LSP requests received from the client.
  """

  require Logger

  @doc """
  Dispatches to the appropriate function for the given `method`.
  """
  @spec handle_method(String.t(), term()) :: term()
  def handle_method(method, params) do
    case method do
      "initialize" -> handle_initialize(params)
      _other -> unknown(method, params)
    end
  end

  @spec handle_initialize(map()) :: LSP.InitializeResult.t()
  defp handle_initialize(params) do
    Logger.debug("request [initialize]")
    Logger.debug(Jason.encode!(params))

    %LSP.InitializeResult{
      capabilities: %{
        "codeActionProvider" => true,
        "definitionProvider" => true,
        "hoverProvider" => true,
        "textDocumentSync" => 1
      },
      serverInfo: %{
        "name" => "Educational LSP",
        "version" => "0.0.1-Beta"
      }
    }
  end

  @spec unknown(String.t(), term()) :: term()
  defp unknown(method, params) do
    Logger.debug("request [#{method}] not handled")
    Logger.debug(Jason.encode!(params))

    {:error, method}
  end
end
