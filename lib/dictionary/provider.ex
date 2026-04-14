defmodule Dictionary.Provider do
  @providers ["dictionaryapi", "sdcv"]
  @config_path Application.app_dir(:educational_lsp, "priv/config.json")

  @moduledoc """
  Manages dictionary provider. 
  """

  defstruct [:provider]

  @doc """
  Returns the selected provider.
  """
  @spec get() :: String.t()
  def get do
    get_config()["dictionary"]
  end

  @spec get_config() :: map()
  defp get_config do
    case File.read(@config_path) do
      {:ok, json} ->
        config = Jason.decode!(json)
        validate_config!(config)
        config

      {:error, reason} ->
        raise "Failed to read config: #{reason}"
    end
  end

  defp validate_config!(config) do
    unless config["dictionary"] in @providers do
      raise "Invalid dictionary option. Must be in #{inspect(@providers)}"
    end
  end
end
