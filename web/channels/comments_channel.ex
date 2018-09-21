defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel
  alias Discuss.{Topic, Comment}

  # First arg is name, using string concat to pull out ID
  def join("comments:" <> topic_id, _auth_params, socket) do
      # {:ok, Socket} | {:ok, map, Socket} | {:error, map}
      topic_id = String.to_integer(topic_id)
      topic = Topic
        |> Repo.get(topic_id)
        # Load up the comments, and each of those also load up the user
        |> Repo.preload(comments: [:user])

      {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    #topic = socket.assigns.topic
    #{topic: topic, user_id: user_id} = socket.assigns
    topic = socket.assigns.topic
    user_id = socket.assigns.user_id
    # IO.puts "++ USER ID: " <> user_id

    # build_assoc can only set up 1 association
    changeset = build_assoc(topic, :comments, user_id: user_id)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        comment = Repo.preload(comment, :user)
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
