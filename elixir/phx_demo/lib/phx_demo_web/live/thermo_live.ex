defmodule PhxDemoWeb.ThermostatLive do
  # use Phoenix.LiveView
  use PhxDemoWeb, :live_view
  alias PhxDemoWeb.Thermostat

  # 默认调用 leex 文件
  @impl true
  def render(assigns) do
    ~L"""
    Current temperature: <%= @temperature %>
    """
    # Phoenix.View.render(MyAppWeb.PageView, "page.html", assigns)
  end

  @impl true
  # def mount(_params, %{"current_user_id" => user_id}, socket) do
  def mount(_params, _session, socket) do
    # temperature = Thermostat.get_user_reading(user_id)
    temperature = 100
    {:ok, assign(socket, :temperature, temperature)}
  end
end
