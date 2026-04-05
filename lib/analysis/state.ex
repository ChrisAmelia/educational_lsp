defmodule State do
  defstruct documents: %{}

  @typedoc """
  Simple map of files to contents
  """
  @type t :: %__MODULE__{documents: map()}

  def new_state do
    Agent.start_link(fn -> %State{} end, name: __MODULE__)
  end

  @doc """
  Adds the given document, `uri` and `text`, to the inner state.
  """
  def open_document(uri, text) do
    Agent.update(__MODULE__, fn state ->
      %{state | documents: Map.put(state.documents, uri, text)}
    end)
  end

  @doc """
  Retrieves the document for the given `uri`.
  """
  def get(uri) do
    Agent.get(__MODULE__, fn state -> Map.get(state.documents, uri) end)
  end

  @doc """
  Retrieves all the documents.
  """
  def get do
    Agent.get(__MODULE__, fn state -> state.documents end)
  end
end
