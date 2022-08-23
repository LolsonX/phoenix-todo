defmodule TodoWeb.ItemsController do
  use TodoWeb, :controller

  alias Todo.Items
  alias Todo.Items.Item

  def index(conn, _params) do
    render(conn, "index.html",
           items: Items.list_items(),
           changeset: Item.changeset(%Item{}, %{}))
  end

  def create(conn, %{"item" => item_params}) do
    Items.create_item(item_params)
    conn
    |> put_flash(:info, "Added item!")
    |> redirect(to: "/")
  end

  def complete(conn, %{"id" => id}) do
    Items.mark_completed(id)
    conn
    |> put_flash(:success, "Completed!")
    |> redirect(to: "/")
  end

  def delete(conn, %{"id" => id}) do
    Items.delete_item(id)
    conn
    |> put_flash(:error, "Deleted")
    |> redirect(to: "/")
  end
end
