defmodule RPC do
  @moduledoc """
  RPC utilities.
  """

  @doc """
  Encodes a message according to the Language Server Protocol (LSP) specification.

  Constructs a message header with the content length followed by the message body.
  The header format is `Content-Length: <length>\r\n\r\n` where `<length>` is the
  byte size of the message body.

  ## Parameters

    - `message`: the message to encode.

  ## Returns

    The encoded message.
  """
  @spec encode_message(String.t()) :: String.t()
  def encode_message(message), do: "Content-Length: #{byte_size(message)}\r\n\r\n#{message}"
end
