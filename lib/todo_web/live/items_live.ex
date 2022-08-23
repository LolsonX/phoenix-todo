defmodule TodoWeb.ItemsLive do
  use TodoWeb, :live_view
  alias Todo.Items

  def mount(_params, _session, socket) do
    Items.subscribe()
    {:ok, fetch(socket)}
  end

  def handle_event("create", %{"item" => item_params}, socket) do
    Items.create_item(item_params)

    {:noreply, socket}
  end

  def handle_event("complete", %{"id" => id}, socket) do
    Items.mark_completed(id)

    {:noreply, socket}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    Items.delete_item(id)

    {:noreply, socket}
  end

  def handle_info({Items, [:item | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket, items: Items.list_items)
  end
end
