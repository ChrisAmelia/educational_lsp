defmodule State do
  @moduledoc """
  Represents the inner state of the language server.
  """

  defstruct documents: %{}

  alias Analysis.TextAnalyzer

  @typedoc """
  Simple map of files to contents
  """
  @type t() :: %__MODULE__{documents: map()}

  @doc """
  Creates a new state.
  """
  def new_state do
    Agent.start_link(fn -> %State{} end, name: __MODULE__)
  end

  @doc """
  Adds the given document, `uri` and `text`, to the inner state.
  """
  @spec open_document(String.t(), String.t()) :: [Diagnostic.t()]
  def open_document(uri, text) do
    Agent.update(__MODULE__, fn state ->
      %{state | documents: Map.put(state.documents, uri, text)}
    end)

    TextAnalyzer.analyze(text)
  end

  @doc """
  Updates the given `uri` with `text`.
  """
  @spec update_document(String.t(), String.t()) :: [Diagnostic.t()]
  def update_document(uri, text) do
    Agent.update(__MODULE__, fn state ->
      %{state | documents: Map.put(state.documents, uri, text)}
    end)

    TextAnalyzer.analyze(text)
  end

  @doc """
  Returns the word the cursor.

  ## Parameters

    * `uri`: the document's URI.
    * `line_number`: the line number, zero-based.
    * `index`: the position inside the document, zero-based.
  """
  @spec get_word_under_cursor(String.t(), integer(), integer()) :: String.t()
  def get_word_under_cursor(uri, line_number, index) do
    document = State.get(uri)
    line = document |> String.split("\n") |> Enum.at(line_number)
    words = String.split(line)

    Enum.with_index(words, 0)
    |> Enum.reduce({nil, 0}, fn {word, _word_index}, {acc, current_index} ->
      word_length = String.length(word)

      if index >= current_index and index < current_index + word_length do
        {word, current_index + word_length}
      else
        # +1 for the space
        {acc, current_index + word_length + 1}
      end
    end)
    |> elem(0)
    |> String.replace(",", "")
    |> String.replace(".", "")
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
