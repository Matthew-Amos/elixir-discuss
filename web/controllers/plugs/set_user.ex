defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  
  alias Discuss.Repo
  alias Discuss.User

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      # Second value from the boolean will get assigned
      user = user_id && Repo.get(User, user_id) ->
        # Has a user id - put it into conn.assigns.user
        assign(conn, :user, user)
      true ->
        # Connection does not have a user id
        assign(conn, :user, nil)
    end
  end
end
