defmodule Todo.Items do
  alias Todo.Items.Item
  alias Todo.Repo
  import Ecto.Query

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
  end

  def delete_item(id) do
    Repo.get(Item, id)
    |> Repo.delete
  end

  def create_item(params) do
    %Item{}
    |> Item.changeset(params)
    |> Repo.insert
  end
end
