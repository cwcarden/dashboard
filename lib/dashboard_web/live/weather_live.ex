defmodule DashboardWeb.WeatherLive do
  use DashboardWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(3000, :update_weather)

    {:ok,
     assign(socket,
       wind_speed: random_wind(),
       temperature: random_temp(),
       rain_chance: random_rain()
     )}
  end

  @impl true
  def handle_info(:update_weather, socket) do
    {:noreply,
     assign(socket,
       wind_speed: random_wind(),
       temperature: random_temp(),
       rain_chance: random_rain()
     )}
  end

  defp random_wind, do: "#{Enum.random(1..15)} mph"
  defp random_temp, do: "#{Enum.random(60..80)}°F"
  defp random_rain, do: "#{Enum.random(0..100)}%"

  @impl true
  def render(assigns) do
    ~H"""
    <div class="data-box weather">
      <h2>Current Weather</h2>
      <ul>
        <li><span class="label">Wind Speed:</span><span class="value wind"><%= @wind_speed %></span></li>
        <li><span class="label">Temperature:</span><span class="value weather-temp"><%= @temperature %></span></li>
        <li><span class="label">Rain Chance:</span><span class="value weather-temp"><%= @rain_chance %></span></li>
      </ul>
    </div>
    """
  end
end
