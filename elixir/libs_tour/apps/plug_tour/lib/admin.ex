defmodule AdminRouter do
  use Plug.Router

  get "/first" do
    send_resp(conn, 200, 'admin router / first')
  end
end
