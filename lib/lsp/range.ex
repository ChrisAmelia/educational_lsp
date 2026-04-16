defmodule LSP.Range do
  @moduledoc ~S"""
  From LSP specification,  
  A range is a text document expressed as (zero-based) start and end positions.
  """

  @typedoc ~S"""
    A range is a text document expressed as (zero-based) start and end positions.
  """
  @type t :: %__MODULE__{
          start: LSP.Position.t(),
          end: LSP.Position.t()
        }
  @derive Jason.Encoder
  defstruct [:start, :end]
end
