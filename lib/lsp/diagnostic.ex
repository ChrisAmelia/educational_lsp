defmodule Diagnostic do
  @moduledoc """
  Represents a diagnostic, such as a compiler error or warning.
  """

  @typedoc ~S"""
    * `range`: The range at which the message applies.
    * `severity`: The diagnostic's severity.
    * `source`:  A human-readable string describing the source of this diagnostic.
    * `message`: The diagnostic's message.
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
