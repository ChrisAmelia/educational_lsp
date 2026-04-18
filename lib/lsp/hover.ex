defmodule LSP.HoverResult do
  @moduledoc """
  Represents the result of a hover request in the Language Server Protocol (LSP).
  """

  @typedoc ~S"""
  # Fields

  * `contents`: A string containing the hover content to display.
  """
  @type t :: %__MODULE__{
          contents: String.t()
        }
  @derive Jason.Encoder
  defstruct [:contents]
end
