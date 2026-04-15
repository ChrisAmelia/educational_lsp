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

    phonetic = get_phonetics(data)
    definitions = get_definitions(data)

    phonetic <>
      "\n\n" <>
      definitions
  rescue
    _ -> "Couldn't find definition for '#{word}'"
  end

  defp get_phonetics(data) do
    phonetics = get_in(data, [Access.at(0), "phonetics"])

    phonetics
    |> Enum.map(fn map -> map["text"] end)
    |> Enum.filter(&(&1 != nil))
    |> Enum.with_index(1)
    |> Enum.map_join(", ", fn {entry, index} -> "(#{index}) #{entry}" end)
  end

  defp get_definitions(data) do
    definitions = get_in(data, [Access.at(0), "meanings", Access.at(0), "definitions"])

    definitions
    |> Enum.with_index(1)
    |> Enum.map_join("\n", fn {entry, _index} -> "1. #{entry["definition"]}" end)
  end
end
