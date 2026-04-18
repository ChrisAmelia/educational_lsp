defmodule LSP.Position do
  @moduledoc ~S"""
  From LSP specification,  
  Position in a text document expressed as zero-based line and zero-based character offset.
  """

  @typedoc ~S"""
  # Fields

    * `line`: Line position in a document (zero-based).
    * `character`: Character offset on a line in a document (zero-based).
  """
  @type t :: %__MODULE__{line: integer, character: integer}
  @derive Jason.Encoder
  defstruct [:line, :character]
end
