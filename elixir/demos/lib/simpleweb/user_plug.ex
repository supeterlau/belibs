defmodule SimpleWeb.UserRouter do
  alias SimpleWeb.Router
  use Router

  def route("GET", ["users", user_id], conn) do
    # /users/<user_id>
    # conn |> Plug.Conn.send_resp(200, "Request user @#{user_id}")
    content = EEx.eval_file("simpleweb/templates/show_user.eex", [user_id: user_id])
    conn
    |> Plug.Conn.put_resp_content_type("text/html")
    |> Plug.Conn.send_resp(200, content)
  end
end
