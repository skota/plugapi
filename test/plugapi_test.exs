defmodule PlugapiTest do
  use ExUnit.Case
  use Plug.Test
  alias Plugapi.Router
  doctest Plugapi

  test "greets the world" do
    assert Banditplugapi.hello() == :world
  end

  # test /hi
  test "user can access /hi" do
    conn = conn(:get, "/hi")
    conn = Router.call(conn, [])
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "hello"
  end

  # test /secret without api key
  test "user cannot access /secret without x-api-key" do
    conn = conn(:get, "/secret")

    conn = Router.call(conn, [])

    assert conn.state == :sent
    assert conn.status == 400
    assert conn.resp_body == "Invalid request"

  end

  # test /secret with api key
  test "user cannot access /secret with incorrect x-api-key" do
    conn = conn(:get, "/secret")
           |> put_req_header("x-api-key", "appl12")

    conn = Router.call(conn, [])

    assert conn.state == :sent
    assert conn.status == 400
    assert conn.resp_body == "Invalid request"

  end

  test "user can access /secret with correct x-api-key" do
    conn = conn(:get, "/secret")
           |> put_req_header("x-api-key", "secret123")

    conn = Router.call(conn, [])

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "You have access to the secret!"

  end


end
