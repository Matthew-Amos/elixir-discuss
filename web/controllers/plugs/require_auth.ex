defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn    # for halt()
  import Phoenix.Controller # for put_flash, redirect

  alias Discuss.Router.Helpers

  # Called once during application lifecycle
  def init(_params) do
  end

  # Remember that _params is the output of init()
  def call(conn, _params) do
      if conn.assigns[:user] do
        conn
      else
        conn
        |> put_flash(:error, "Must be logged in")
        |> redirect(to: Helpers.topic_path(conn, :index))
        |> halt()
      end
  end
end
