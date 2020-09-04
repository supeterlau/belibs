defmodule Http do
  require Logger

  def start_link(port: port, dispatch: dispatch) do
    {:ok, socket} = :gen_tcp.listen(
      port,
      active: false,
      packet: :http_bin,
      reuseaddr: true
    )
    Logger.info("Accepting connections on port #{port}")

    {:ok, spawn_link(Http, :accept, [socket, dispatch])}
  end

  def accept(socket, dispatch) do
    Logger.info("start accept")
    {:ok, request} = :gen_tcp.accept(socket)
    spawn(fn -> 
      dispatch.(request)
    end)
    Logger.info("next accept")

    accept(socket, dispatch)
  end

  def accept_raw(socket) do
    {:ok, request} = :gen_tcp.accept(socket)
    spawn(fn ->
      body = "Hello gen_tcp! The time is #{Time.to_string(Time.utc_now())}"
      response = """
      HTTP/1.1 200\r
      Content-Type: text/html\r
      Content-Length: #{byte_size(body)}\r
      \r
      #{body}
      """
      send_response(request, response)
    end)

    accept_raw(socket)
  end

  def send_response(socket, response) do
    :gen_tcp.send(socket, response)
    :gen_tcp.close(socket)
  end

  def child_spec(opts) do
    # Application 中调用 child_spec 启动模块
    # opts 为 keyword lists -> port: port
    %{id: Http, start: {Http, :start_link, [opts]}}
  end
end


