defmodule Controllers.RegisterController do
    import  Plug.Conn  
    import Ecto.Changeset
    alias   Plugapi.Model  #contains functions to call changeset

    def register(conn) do
        # IO.puts inspect conn.body_params

        case Model.create_user(conn.body_params) do
            {:ok, _user} ->
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(201, Poison.encode!(%{message: "User created"}))

            {:error, changeset} ->   
                #get errors from changeset
                errors = traverse_errors(changeset, fn {msg, opts} ->
                   Enum.reduce(opts, msg, fn {key, value}, acc ->
                    String.replace(acc, "%{#{key}}", to_string(value))
                    end)
                end)

                #send response back
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(401, Poison.encode!(%{message: errors}))
        end
    end
end