defmodule Controllers.TaskController do
    import Plug.Conn  #we need this to be able to access conn object
    alias   Plugapi.Model  #contains functions to call changeset
       
    #get task
    def get_task(conn) do
        id = conn.params["id"]  
        case Model.get_task(id) do
            :error ->                   
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(401, Poison.encode!(%{message: "Unable to create task"}))            
            task ->                
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(200, Poison.encode!(%{task: task}))            
        end


    end

    #create task
    def create_task(conn) do
        # IO.puts inspect conn.body_params
        case Model.create_task(conn.body_params) do
            :error ->                   
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(401, Poison.encode!(%{message: "Unable to create task"}))            
            task ->                
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(201, Poison.encode!(%{token: "created task"}))            
        end

    end

    def update_task(conn) do
        id = conn.params["id"]  
        case Model.update_task(id, conn.body_params) do
            :error ->                   
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(401, Poison.encode!(%{message: "Unable to create task"}))            
            task ->                
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(200, Poison.encode!(%{token: "updated task"}))            
        end
    end

    def delete_task(conn) do
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Poison.encode!(%{message: "inside task controller - delete task "}))
    end

end