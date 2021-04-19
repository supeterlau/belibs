defmodule PhxDemoWeb.Router do
  use PhxDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session

    # liveview
    plug :fetch_live_flash
    # 配置 LiveView layout
    plug :put_root_layout, {PhxDemoWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxDemoWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/thermostat", ThermostatLive
    # live "/thermostat", ThermostatLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxDemoWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PhxDemoWeb.Telemetry
    end
  end
end
