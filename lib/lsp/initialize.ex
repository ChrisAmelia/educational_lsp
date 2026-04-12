defmodule LSP.InitializeResult do
  @moduledoc """
  The server response to a `initialize` request.
  """

  @derive Jason.Encoder
  defstruct [:capabilities, :serverInfo]

  @typedoc """
  The server response to a `initialize` request.
  # Fields

    * `capabilities`: server capabilities.
    * `serverInfo`: may contain the name and the version.
  """
  @type initialize_result() :: %__MODULE__{
          capabilities: map(),
          serverInfo: map() | nil
        }
end
