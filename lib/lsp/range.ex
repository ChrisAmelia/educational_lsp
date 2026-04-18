defmodule LSP.Range do
  @moduledoc ~S"""
  From LSP specification,  
  A range is a text document expressed as (zero-based) start and end positions.
  """

  @typedoc ~S"""
  ## Fields

    * `start`: The range's start position.
    * `end`: The range's end position.
  """
  @type t :: %__MODULE__{
          start: LSP.Position.t(),
          end: LSP.Position.t()
        }
  @derive Jason.Encoder
  defstruct [:start, :end]

  @doc """
  Returns the ranges for the given start and end.
  """
  @spec line_range(integer(), integer(), integer()) :: LSP.Range.t()
  def line_range(line, start_index, end_index) do
    %LSP.Range{
      start: %LSP.Position{
        line: line,
        character: start_index
      },
      end: %LSP.Position{
        line: line,
        character: end_index
      }
    }
  end
end
