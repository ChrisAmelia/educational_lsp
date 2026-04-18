defmodule LSP.InitializeResult do
  @moduledoc """
  The server response to a `initialize` request.
  """

  @derive Jason.Encoder
  defstruct [:capabilities, :serverInfo]

  @typedoc """
  ## Fields

    * `capabilities`: server capabilities.
    * `serverInfo`: may contain the name and the version.
  """
  @type t :: %__MODULE__{
          capabilities: map(),
          serverInfo: map() | nil
        }
end
