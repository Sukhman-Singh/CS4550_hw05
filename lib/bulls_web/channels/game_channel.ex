defmodule BullsWeb.GameChannel do
  use BullsWeb, :channel

  @impl true
  def join("game:1" <> _id, payload, socket) do
    if authorized?(payload) do
	game = Bulls.Game.new()
	socket = assign(socket, :game, game)
	view = Bulls.Game.view(game)
      {:ok, view, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("guess", %{"letter" => ll}, socket) do
	IO.puts "HELLO2"
	game0 = socket.assigns[:game]
	game1 = Bulls.Game.makeGuess(game0, ll)
	socket = assign(socket, :game, game1)
	IO.inspect game1
	view = Bulls.Game.view(game1)
    {:reply, {:ok, view}, socket}
  end

  @impl true
  def handle_in("reset", _, socket) do
	game = Bulls.Game.new()
	socket = assign(socket, :game, game)
	view = Bulls.Game.view(game)
    	{:reply, {:ok, view}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (game:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
