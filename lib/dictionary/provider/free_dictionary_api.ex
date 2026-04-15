defmodule Dictionary.Provider.FreeDictionaryAPI do
  @moduledoc """
  Free Dictionary API provider implementation.
  """

  require Logger

  @spec get_definition(String.t()) :: String.t()
  def get_definition(word) do
    client = Tesla.client([])

    {_, env} = Tesla.get(client, "https://api.dictionaryapi.dev/api/v2/entries/en/" <> word)
    data = Jason.decode!(env.body)

    phonetic = get_in(data, [Access.at(0), "phonetic"])
    definitions = get_in(data, [Access.at(0), "meanings", Access.at(0), "definitions"])

    description =
      definitions
      |> Enum.with_index(1)
      |> Enum.map_join("\n", fn {entry, index} -> "#{index}. #{entry["definition"]}" end)

    phonetic <>
      "\n\n" <>
      description
  rescue
    _ -> "Couldn't find definition for '#{word}'"
  end
end
