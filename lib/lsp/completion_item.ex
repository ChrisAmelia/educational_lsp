defmodule LSP.CompletionItem do
  @moduledoc ~S"""
  Response to `textDocument/completion`.
  """

  @typedoc ~S"""
  # Fields

    * `label`: The label of this completion item.
    * `kind`: The kind of completion item.
  """
  @derive Jason.Encoder
  @type t :: %__MODULE__{
          label: String.t(),
          kind: LSP.CompletionItemKind.t()
        }
  defstruct [:label, :kind]
end

defmodule LSP.CompletionItemKind do
  @moduledoc ~S"""
  Completion item kinds constants.
  """
  @type t ::
          1
          | 2
          | 3
          | 4
          | 5
          | 6
          | 7
          | 8
          | 9
          | 10
          | 11
          | 12
          | 13
          | 14
          | 15
          | 16
          | 17
          | 18
          | 19
          | 20
          | 21
          | 22
          | 23
          | 24
          | 25

  def text, do: 1
  def method, do: 2
  def function, do: 3
  def constructor, do: 4
  def field, do: 5
  def variable, do: 6
  def class, do: 7
  def interface, do: 8
  def module, do: 9
  def property, do: 10
  def unit, do: 11
  def value, do: 12
  def enum, do: 13
  def keyword, do: 14
  def snippet, do: 15
  def color, do: 16
  def file, do: 17
  def reference, do: 18
  def folder, do: 19
  def enumMember, do: 20
  def constant, do: 21
  def struct, do: 22
  def event, do: 23
  def operator, do: 24
  def type_parameter, do: 25
end
