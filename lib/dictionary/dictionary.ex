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
    if word != nil and word != "" do
      {desc, _exit_status} = System.cmd("sdcv", ["#{word}"], [])
      lines = String.split(desc, "\n")

      # First 4 lines of 'sdcv' aren't necessary
      shorten_desc = lines |> Enum.drop(4) |> Enum.take(20) |> Enum.join("\n")

      "**" <>
        word <>
        "**" <>
        "\n" <>
        "length: #{String.length(word)}" <>
        "\n\n" <>
        shorten_desc
    end
  end
end
