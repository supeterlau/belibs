defmodule SimpleWeb.UserRouter do
  alias SimpleWeb.{Router, User}
  use Router

  require EEx
  EEx.function_from_file :defp, :template_show_user, "lib/simple_web/templates/show_user.eex", [:user]

  def route("GET", ["users", user_id], conn) do
    IO.puts "user_id is integer? #{is_integer(user_id)}"

    # /users/<user_id>
    # conn |> Plug.Conn.send_resp(200, "Request user @#{user_id}")
    # content = EEx.eval_file("lib/simple_web/templates/show_user.eex", [user_id: user_id])
    # 预编译
    # content = template_show_user(user_id)

    case SimpleWeb.Repo.get(User, user_id) do
      nil ->
        conn
        |> Plug.Conn.send_resp(404, "User with that ID not found, sry")
      user ->
        content = template_show_user(user)
        conn
        |> Plug.Conn.put_resp_content_type("text/html")
        |> Plug.Conn.send_resp(200, content)
    end
  end
end
