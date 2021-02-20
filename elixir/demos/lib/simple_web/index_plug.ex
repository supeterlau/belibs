defmodule SimpleWeb.IndexRouter do
  @moduledoc """
  {:ok, _} = Plug.Adapters.Cowboy.http SimpleWeb.IndexRouter, []
  """

  alias SimpleWeb.UserRouter
  use SimpleWeb.Router

  @user_router_options UserRouter.init([])
  # @api_logger_options ApiLogPlug.init([])

  def route("GET", ["users" | _path], conn) do
    conn 
    # |> ApiLogPlug.call(@api_logger_options)
    |> UserRouter.call(@user_router_options)
  end

  def route(_method, _path, conn) do
    conn |> Plug.Conn.send_resp(404, "Page Not Found, sry")
  end
end
