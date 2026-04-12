defmodule State do
  @moduledoc """
  Represents the inner state of the language server.
  """

  defstruct documents: %{}

  alias Analysis.TextAnalyzer

  @typedoc """
  Simple map of files to contents
  """
  @type state() :: %__MODULE__{documents: map()}

  @doc """
  Creates a new state.
  """
  def new_state do
    Agent.start_link(fn -> %State{} end, name: __MODULE__)
  end

  @doc """
  Adds the given document, `uri` and `text`, to the inner state.
  """
  @spec open_document(String.t(), String.t()) :: [Diagnostic.diagnostic()]
  def open_document(uri, text) do
    Agent.update(__MODULE__, fn state ->
      %{state | documents: Map.put(state.documents, uri, text)}
    end)

    TextAnalyzer.analyze(text)
  end

  @doc """
  Retrieves the document for the given `uri`.

  ## Parameters

    - `uri`: the file's path.

  ## Returns

    The content of the file.
  """
  @spec get(String.t()) :: String.t()
  def get(uri) do
    Agent.get(__MODULE__, fn state -> Map.get(state.documents, uri) end)
  end

  @doc """
  Retrieves all the documents.
  """
  @spec get() :: map()
  def get do
    Agent.get(__MODULE__, fn state -> state.documents end)
  end
end
