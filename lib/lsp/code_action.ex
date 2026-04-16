defmodule LSP.CodeAction do
  @moduledoc ~S"""
  From LSP specification,  
  The code action request is sent from the client to the server to compute commands for a given text document and range.
  """

  @typedoc ~S"""
    * `title`: A short, human-readable, title for this code action.
    * `edit`: The workspace edit this code action performs.
  """
  @type t :: %__MODULE__{
          title: String.t(),
          edit: LSP.WorkspaceEdit.t()
        }
  @derive Jason.Encoder
  defstruct [:title, :edit]
end

defmodule LSP.TextEdit do
  @moduledoc """
  From LSP specification,  
  A textual edit applicable to a text document.
  """

  @typedoc ~S"""
    * `range`: The range of the text document to be manipulated.
    * `newText`: The string to be inserted.
  """
  @type t :: %__MODULE__{
          range: LSP.Range.t(),
          newText: String.t()
        }
  @derive Jason.Encoder
  defstruct [:range, :newText]
end

defmodule LSP.WorkspaceEdit do
  @moduledoc ~S"""
  From LSP specification,  
  A workspace edit represents changes to many resources managed in the workspace.
  """

  @typedoc ~S"""
    * `changes`: Holds changes to existing resources.
  """
  @type t :: %__MODULE__{
          changes: %{
            optional(String.t()) => [LSP.TextEdit.t()]
          }
        }
  @derive Jason.Encoder
  defstruct [:changes]
end
