defmodule Plugapi.Router do
  use Plug.Router
  # add this line
  alias Plugapi.Users

  plug :match
  plug :dispatch

  # show public api route
  get "/hi" do
    send_resp(conn, 200, "hello")
  end


  # public route to display users
  get "/users" do
    # 1 - get data
    {_status, users} = Users.get_users()
            |> Enum.map(fn user ->
              # we are not interested in __struct__ and __meta__, so we iterate
              # through the map and pick up fields we need
              %{"first_name" => user.first_name,
                "last_name" => user.last_name,
                "email" => user.email}
            end)
            |> JSON.encode

    # 2 - set response headers. we are returninhg json
    conn = put_resp_content_type(conn, "application/json")

    # 3 - return data
    send_resp(conn, 200, users )
  end


  # show protected api route
  get "/secret" do
    check_headers(conn, fn ->
      send_resp(conn, 200, "You have access to the secret!")
    end)
  end

  defp check_headers(conn, action) do
    # IO.inspect get_req_header(conn, "x-api-key")
    result =get_req_header(conn, "x-api-key")
    if result != [] and List.first(result) == "secret123" do
      action.()
    else
      send_resp(conn, 400, "Invalid request")
    end
  end

  # Handle requests to unknown routes
  match _ do
    send_resp(conn, 404, "Not found")
  end
end
