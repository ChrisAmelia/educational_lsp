defmodule Dictionary do
  @moduledoc """
  Dictionary to provide definitions.
  """

  @doc """
  Returns the definition for the given `word`.

  ## Parameters

    * `word`: the word to look the definition of.
  """
  @spec get_definition(String.t()) :: String.t()
  def get_definition(word) do
    provider = Dictionary.Provider.get()
    impl_module = get_impl(provider)
    impl_module.get_definition(word)
  end

  defp get_impl("sdcv"), do: Dictionary.Provider.SDCV

  defp get_impl("dictionaryapi"), do: Dictionary.Provider.FreeDictionaryAPI
end
