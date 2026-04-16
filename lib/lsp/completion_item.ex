defmodule LSP.CompletionItem do
  @moduledoc ~S"""
  Response to `textDocument/completion`.
  """

  @typedoc ~S"""
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
          :text
          | :method
          | :function
          | :constructor
          | :field
          | :variable
          | :class
          | :interface
          | :module
          | :property
          | :unit
          | :value
          | :enum
          | :keyword
          | :snippet
          | :color
          | :file
          | :reference
          | :folder
          | :enumMember
          | :constant
          | :struct
          | :event
          | :operator
          | :typeParameter

  def text, do: :text
  def method, do: :method
  def function, do: :function
  def constructor, do: :constructor
  def field, do: :field
  def variable, do: :variable
  def class, do: :class
  def interface, do: :interface
  def module, do: :module
  def property, do: :property
  def unit, do: :unit
  def value, do: :value
  def enum, do: :enum
  def keyword, do: :keyword
  def snippet, do: :snippet
  def color, do: :color
  def file, do: :file
  def reference, do: :reference
  def folder, do: :folder
  def enumMember, do: :enumMember
  def constant, do: :constant
  def struct, do: :struct
  def event, do: :event
  def operator, do: :operator
  def type_parameter, do: :typeParameter
end
