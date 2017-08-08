defmodule Plugapi.Model do
    alias Plugapi.Repo
    alias Plugapi.User
    alias Plugapi.Task


    def build_user(attrs \\ %{}) do
        #if attrs is missing send empty struct
        %User{}
        |> User.changeset(attrs)
    end

    # attrs are passed from registercontroller register function
    def create_user(attrs) do
        attrs
        |> build_user
        |> Repo.insert
    end

    def get_user_by_email(email), do: Repo.get_by(User, email: email)

    def get_user(%{"email" => email, "password" => pass}) do
        user = get_user_by_email(email)
        cond do
            user && Comeonin.Bcrypt.checkpw(pass, user.password_hash) ->
                user
        true ->
            :error
        end
    end

    def get_task(id), do: Repo.get(Task, id)

    def build_task(attrs \\ %{}) do
        #if attrs is missing send empty struct
        %Task{}
        |> Task.changeset(attrs)
    end

    def create_task(attrs) do
        #if attrs is missing send empty struct
        attrs
        |> build_task
        |> Repo.insert       
    end


    def update_task(id, attrs) do
        get_task(id)
        |> Task.changeset(attrs)
        |> Repo.update
    end

end
