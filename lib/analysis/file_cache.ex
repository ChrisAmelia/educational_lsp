defmodule FileCache do
  @moduledoc """
  Simple cache to store a list of words.
  """
  @config_path Application.app_dir(:educational_lsp, "priv/words.txt")
  @file_content File.read!(@config_path) |> String.split("\n")

  def get_list_of_words, do: @file_content
end
