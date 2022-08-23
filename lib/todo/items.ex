defmodule Todo.Items do
  alias Todo.Items.Item
  alias Todo.Repo
  import Ecto.Query

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Todo.PubSub, @topic)
  end

  defp broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Todo.PubSub, @topic, {__MODULE__, event, result})
  end

  def get_item(id) do
    Repo.get(Item, id)
  end

  def list_items() do
    Item
    |> order_by(desc: :id)
    |> Repo.all
  end

  def mark_completed(id) do
    Repo.get(Item, id)
    |> Ecto.Changeset.change(completed: true)
    |> Repo.update
    |> broadcast_change([:item, :updated])
  end

  def delete_item(id) do
    Repo.get(Item, id)
    |> Repo.delete
    |> broadcast_change([:item, :deleted])
  end

  def create_item(params) do
    %Item{}
    |> Item.changeset(params)
    |> Repo.insert
    |> broadcast_change([:item, :created])
  end
end
