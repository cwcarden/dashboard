defmodule DashboardWeb.PirigationLive do
  use DashboardWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(5000, :update_schedule)

    {:ok,
     assign(socket,
       last_runtime: formatted_time(-5),
       next_runtime: formatted_time(5)
     )}
  end

  @impl true
  def handle_info(:update_schedule, socket) do
    {:noreply,
     assign(socket,
       last_runtime: formatted_time(-1),
       next_runtime: formatted_time(6)
     )}
  end

  defp formatted_time(shift_hours) do
    Timex.now()
    |> Timex.shift(hours: shift_hours)
    |> Timex.format!("{YYYY}-{0M}-{0D} {h12}:{m} {AM}")
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="data-box pirigation">
      <h2>PiRigation</h2>
      <ul>
        <li>
          <span class="label">Last Runtime:</span>
          <span class="value"><%= @last_runtime %></span>
        </li>
        <li>
          <span class="label">Next Runtime:</span>
          <span class="value"><%= @next_runtime %></span>
        </li>
      </ul>
    </div>
    """
  end
end
