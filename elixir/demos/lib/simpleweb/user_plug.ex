defmodule SimpleWeb.UserRouter do
  alias SimpleWeb.Router
  use Router

  require EEx
  EEx.function_from_file :defp, :template_show_user, "lib/simpleweb/templates/show_user.eex", [:user_id]

  def route("GET", ["users", user_id], conn) do
    # /users/<user_id>
    # conn |> Plug.Conn.send_resp(200, "Request user @#{user_id}")
    # content = EEx.eval_file("lib/simpleweb/templates/show_user.eex", [user_id: user_id])
    # 预编译
    content = template_show_user(user_id)
    conn
    |> Plug.Conn.put_resp_content_type("text/html")
    |> Plug.Conn.send_resp(200, content)
  end
end
