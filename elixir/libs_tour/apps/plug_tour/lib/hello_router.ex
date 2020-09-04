defmodule HelloRouter do
  use Plug.Router
  # use Plug.Builder

  plug Plug.Logger, log: :debug
  # plug :plug_func, upper: true
  plug Plug.Parsers, parsers: [:urlencoded, :json],
                   pass: ["text/*"],
                   json_decoder: Jason
  plug Plug.Parsers,
     parsers: [
       :url_encoded,
       {:multipart, length: 20_000_000} # Increase to 20MB max upload
     ]

  plug :match
  plug :dispatch

  get "/first/:word" do
    send_resp(conn, 200, "first router " <> word)
  end

  get "/second/*rest" do
    send_resp(conn, 200, "second router #{inspect rest}")
  end

  post "/third" do
    conn.body_params |> IO.inspect(label: "body")
    conn.query_params |> IO.inspect(lable: "query")
    send_resp(conn, 200, "third router")
  end

  forward "/admin", to: AdminRouter

  def plug_func(conn, opts) do
    body = if opts[:upper], do: "woozoo" |> String.upcase, else: "woozoo"
    send_resp(conn, 200, body)
  end

  # match _ 后续的部分都无法被匹配的
  match _ do
    send_resp(conn, 404, "oops")
  end
end
