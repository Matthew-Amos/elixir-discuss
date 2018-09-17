defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  def join(name, _auth_params, socket) do
      # {:ok, Socket} | {:ok, map, Socket} | {:error, map}
      IO.puts("+++++")
      IO.puts(name)
      IO.puts("+++++")
      IO.inspect(socket)
      {:ok, %{hey: "there"}, socket}
  end

  def handle_in(name, message, socket) do
    IO.puts("++++++")
    IO.puts(name)
    IO.inspect(message)
    
    {:reply, :ok, socket}
  end
end
