defmodule LSP.HoverResult do
  @moduledoc """
  Represents the result of a hover request in the Language Server Protocol (LSP).

  This module defines the structure returned to the client when handling a
  `textDocument/hover` request. The hover result provides contextual information
  about the symbol under the cursor, typically displayed as a tooltip in the editor.

  ## Fields

  * `contents`: A string containing the hover content to display. This typically
    includes documentation or type information about the symbol.
  """

  @type t :: %__MODULE__{
          contents: String.t()
        }
  @derive Jason.Encoder
  defstruct [:contents]
end
