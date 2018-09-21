defmodule Discuss.UserSocket do
  use Phoenix.Socket

  # channel "room:*", Discuss.RoomChannel
  channel "comments:*", Discuss.CommentsChannel

  transport :websocket, Phoenix.Transports.WebSocket

  # Token will be passed as a string, hence key => var syntax
  def connect(%{"token" => token}, socket) do
    #IO.puts token
    case Phoenix.Token.verify(socket, "key", token) do
        {:ok, user_id} ->
          {:ok, assign(socket, :user_id, user_id)}
        {:error, _error} ->
          :error
    end
  end

  def id(_socket), do: nil
end
