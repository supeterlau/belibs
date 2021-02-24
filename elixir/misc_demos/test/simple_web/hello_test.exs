defmodule SimpleWeb.HelloTest do
  use ExUnit.Case, async: true
  use Plug.Test
  use Demos.RepoCase

  @router_opts SimpleWeb.UserRouter.init([])
  test "returns a user" do
    conn = conn(:get, "/users/1")
    conn = SimpleWeb.UserRouter.call(conn, @router_opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert String.match?(conn.resp_body, ~r/Fluffums/)
  end
end
