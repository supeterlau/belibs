defmodule Http.PlugAdapter do
  @moduledoc """
  set plug
  prepare dispatch function
  start web server
  """

  def dispatch(request, plug) do
    %Plug.Conn{
      adapter: {Http.PlugAdapter, request},
      # adapter: {__MODULE__, request},
      owner: self()
    }
    |> plug.call([])  # => CurrentTime.call/2
  end

  def send_resp(socket, status, headers, body) do
    # 类似 lib/http.ex 中构造 response
    response = "HTTP/1.1 #{status}\r\n#{headers(headers)}Content-Length: #{byte_size(body)}\r\n\r\n#{body}"

    Http.send_response(socket, response)
    {:ok, nil, socket}
  end

  # plug: CurrentTime
  def child_spec(plug: plug, port: port) do
    Http.child_spec(port: port, dispatch: &dispatch(&1, plug))
  end

  def headers(headers) do
    # [{"aaa", "bbb"},{"ccc","ddd"}]
    # 将元组列表转为 headers 字符串
    Enum.reduce(headers, "", fn {key, value}, acc ->
      acc <> key <> ": " <> value <> "\r\n"
    end)
  end
end
