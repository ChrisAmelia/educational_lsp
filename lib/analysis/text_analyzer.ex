defmodule Analysis.TextAnalyzer do
  @moduledoc """
  Collection of functions that performs text analysis.
  """

  @doc """
  Performs text analysis on the given `text` and return diagnostics.

  ## Parameters

    - `text`: The input text to analyze.

  ## Returns

    A list of diagnostics.
  """
  @spec analyze(String.t()) :: [Diagnostic.t()]
  def analyze(text) do
    diagnostics =
      text
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.reduce([], fn {line, row}, acc ->
        case :binary.match(line, "VS Code") do
          {start, length} ->
            diagnostic = %Diagnostic{
              range: LSP.Range.line_range(row, start, start + length),
              severity: 1,
              message: "VS C*de is not allowed.",
              source: "Educational LSP"
            }

            [diagnostic | acc]

          _ ->
            acc
        end
      end)

    diagnostics
  end
end
