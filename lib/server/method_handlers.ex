defmodule LSP.MethodHandlers do
  @spec handle_method(String.t(), term()) :: term()
  def handle_method(method, params) do
    case method do
      "initialize" -> handle_initialize(params)
      _other -> {:error, "Method not found"}
    end
  end

  defp handle_initialize(_params) do
    %{
      "capabilities" => %{
        "textDocumentSync" => 1,
        "hoverProvider" => true,
        "completionProvider" => %{"resolveProvider" => false}
      }
    }
  end
end
