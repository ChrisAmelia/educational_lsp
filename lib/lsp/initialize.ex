defmodule LSP.InitializeResult do
  @derive Jason.Encoder
  defstruct [:capabilities, :serverInfo]

  @typedoc """
  The server response to a `initialize` request.
  # Fields

    * `capabilities`: server capabilities.
    * `serverInfo`: may contain the name and the version.
  """
  @type t :: %__MODULE__{
          capabilities: map(),
          serverInfo: map() | nil
        }
end
