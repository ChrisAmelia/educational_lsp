defmodule Diagnostic.Position do
  @moduledoc """
  Position in a text document expressed as zero-based line and zero-based character offset.
  """

  @typedoc """
    Position in a text document expressed as zero-based line and zero-based character offset.
  """
  @type t :: %__MODULE__{line: integer, character: integer}
  @derive Jason.Encoder
  defstruct [:line, :character]
end

defmodule Diagnostic.Range do
  @moduledoc """
  A range is a text document expressed as (zero-based) start and end positions.
  """

  @typedoc """
    A range is a text document expressed as (zero-based) start and end positions.
  """
  @type range :: %__MODULE__{
          start: Diagnostic.Position.t(),
          end: Diagnostic.Position.t()
        }
  @derive Jason.Encoder
  defstruct [:start, :end]
end

defmodule Diagnostic do
  @moduledoc """
  Represents a diagnostic, such as a compiler error or warning.
  """

  @typedoc """
    Represents a diagnostic, such as a compiler error or warning.
  """
  @derive Jason.Encoder
  @type t :: %__MODULE__{
          range: LSP.Position.t(),
          severity: integer(),
          source: String.t(),
          message: String.t()
        }
  defstruct [:range, :severity, :source, :message]
end
