defmodule DashboardWeb.GreenhouseLive do
  use DashboardWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(2000, :update_greenhouse)
    {:ok, assign(socket, greenhouse: random_greenhouse_data())}
  end

  @impl true
  def handle_info(:update_greenhouse, socket) do
    {:noreply, assign(socket, greenhouse: random_greenhouse_data())}
  end

  defp random_greenhouse_data do
    %{
      humidity: "#{:rand.uniform(30) + 40}%",
      temperature: "#{:rand.uniform(15) + 65}°F",
      o2: "#{:rand.uniform(5) + 19}%",
      ppfd: "#{:rand.uniform(100) + 100} μmol/m²/s"
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="data-box greenhouse">
      <h2>Greenhouse</h2>
      <ul>
        <li>
          <span class="label">Humidity:</span>
          <span class="value humidity"><%= @greenhouse.humidity %></span>
        </li>
        <li>
          <span class="label">Temperature:</span>
          <span class="value temperature"><%= @greenhouse.temperature %></span>
        </li>
        <li>
          <span class="label">O₂:</span>
          <span class="value o2"><%= @greenhouse.o2 %></span>
        </li>
        <li>
          <span class="label">PPFD:</span>
          <span class="value ppfd"><%= @greenhouse.ppfd %></span>
        </li>
      </ul>
    </div>
    """
  end
end
