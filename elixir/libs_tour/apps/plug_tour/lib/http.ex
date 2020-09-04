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

  def read_request(request, acc \\ %{headers: []}) do
    case :gen_tcp.recv(request, 0) |> IO.inspect do
      # 读取 request path
      {:ok, {:http_request, :GET, {:abs_path, full_path}, _}} ->
        read_request(request, Map.put(acc, :full_path, full_path))
      # 读取 header end
      {:ok, :http_eoh} ->
        acc
      # 读取 headers
      {:ok, {:http_header, _, key, _, value}} ->
        read_request(
          request,
          Map.put(acc, :headers, [
            {String.downcase(to_string(key)), value} | acc.headers
          ]))
      # 读取 body
      {:ok, line} ->
        line |> IO.inspect(label: "http line")
        read_request(request, acc)
    end
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


