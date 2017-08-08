defmodule Plugapi.Web do
    use Plug.Router    
    import Joken
    
    @skip_token_verification %{joken_skip: true}

    plug Plug.Parsers, parsers: [:urlencoded, :json],
                   pass:  ["application/json"],
                   json_decoder: Poison

    plug Plug.Logger
    plug :match
    plug Joken.Plug, verify: &Plugapi.Web.verify_function/0 
    plug :dispatch


    def init(options) do
        options
    end

    def start_link do
        # launch cowboy....
        # https://hexdocs.pm/plug/Plug.Adapters.Cowboy.html
        # read cowboy config info from a file?
        # how do i show a message on command line....server running on port xxxx
        {:ok, _} = Plug.Adapters.Cowboy.http Plugapi.Web, [], port: 4400
    end


    # unprotected routes
    get "/", private: @skip_token_verification do
        conn
        |> send_resp(200, "ok")
        |> halt
    end

    # register handler
    post "/register", private: @skip_token_verification do
        Controllers.RegisterController.register(conn)
    end

    # login     
    post "/login", private: @skip_token_verification do
        Controllers.LoginController.login(conn)
    end


    #protected routes    
    get "/task/:id" do
        Controllers.TaskController.get_task(conn)
    end
    
    post "/task" do
        Controllers.TaskController.create_task(conn)
    end

    put "/task/:id" do
        Controllers.TaskController.update_task(conn)
    end

    delete "/task/:id" do
        Controllers.TaskController.delete_task(conn)
    end    
   
    # catch all route
    # https://hexdocs.pm/plug/Plug.Router.html
    match _, private: @skip_token_verification do
        conn
        |> send_resp(404, "Page not found")
        |> halt
    end

    def verify_function() do        
        %Joken.Token{}
        |> with_json_module(Poison)
        |> with_signer(hs256("my_secret"))
        |> with_sub(1234567890)
    end
end