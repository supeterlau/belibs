defmodule SimpleWeb.SimplePlug do
  @moduledoc """
  {:ok, _} = Plug.Adapters.Cowboy.http SimpleWeb.SimplePlug, []
  """

  def init(default_opts) do
    IO.puts "starting up #{__MODULE__}"
    default_opts
  end

  def call_1(conn, _opts) do
    IO.puts "saying yeah"
    # Plug.Conn.send_resp(conn, 200, "Yeah Simple Web - SinatraEx")
    conn
    |> Plug.Conn.put_resp_header("max-api-requests", "1024")
    |> Plug.Conn.put_resp_header("server", "Plug")
    |> Plug.Conn.send_resp(200, "Yeah Simple Web - SinatraEx")
  end

  def call(conn, _opts) do
    format(conn)
    route(conn.method, conn.path_info, conn)
  end

  def route("GET", ["hi"], conn) do
    conn |> Plug.Conn.send_resp(200, "Hi, SinatraEx")
  end

  def route("GET", ["users", user_id], conn) do
    conn |> Plug.Conn.send_resp(200, "Request user @#{user_id}")
  end

  def route(_method, _path, conn) do
    conn |> Plug.Conn.send_resp(404, "Page Not Found, sry")
  end

  def format(conn), do: "method: #{conn.method} path: #{conn.path_info |> inspect()}"
end
