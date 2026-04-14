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
      "textDocument/hover" -> handle_hover(params)
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
        "textDocumentSync" => %{
          "openClose" => true,
          "save" => %{
            "includeText" => true
          }
        }
      },
      serverInfo: %{
        "name" => "Educational LSP",
        "version" => "0.0.1-Beta"
      }
    }
  end

  @spec handle_hover(map()) :: LSP.HoverResult.t()
  defp handle_hover(params) do
    Logger.debug("request [hover]")
    Logger.debug(Jason.encode!(params))

    uri = params["textDocument"]["uri"]
    line_number = params["position"]["line"]
    index = params["position"]["character"]
    word = State.get_word_under_cursor(uri, line_number, index)

    definition =
      case word do
        "" -> nil
        word -> Dictionary.get_definition(word)
      end

    %LSP.HoverResult{
      contents: definition
    }
  end

  @spec unknown(String.t(), term()) :: term()
  defp unknown(method, params) do
    Logger.debug("request [#{method}] not handled")
    Logger.debug(Jason.encode!(params))

    {:error, method}
  end
end
