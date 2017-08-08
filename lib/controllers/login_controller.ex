defmodule Controllers.LoginController do
    import  Plug.Conn  
    import  Joken
    alias   Plugapi.Model  #contains functions to call changeset

    def login(conn) do
        #IO.puts inspect conn.body_params
        case Model.get_user(conn.body_params) do
            :error ->                   
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(401, Poison.encode!(%{message: "email or password is invalid"}))

            user ->
                #login successful - > get token
                token = get_token(user)
                
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(200, Poison.encode!(%{token: token}))
            
        end
    end

    defp get_token(user) do
        # get and sign token
        %{id: user.id}
        |> token
        |> with_validation("id", &(&1 == 1))
        |> with_signer(hs256("my_secret"))
        |> sign
        |> get_compact
    end
end