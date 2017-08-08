defmodule Plugapi.User do
    use Ecto.Schema
    import Ecto.Changeset
    import Comeonin.Bcrypt, only: [hashpwsalt: 1]
    alias Plugapi.User

    @derive {Poison.Encoder, only: [:first_name, :last_name, :email, :id]}
    
    schema "users" do
        field :first_name, :string
        field :last_name, :string
        field :email, :string
        field :password, :string, virtual: true
        field :password_hash, :string
    end

    def changeset(%User{} = user, attrs) do
        user
        |> cast(attrs, [:first_name, :last_name,:email,:password])
        |> validate_required([:first_name, :last_name,:email,:password])
        |> validate_format(:email, ~r/@/, message: "is invalid")
        |> put_hashed_password
    end

    defp put_hashed_password(changeset) do
        case changeset.valid? do
            true ->
                changes = changeset.changes
                put_change(changeset, :password_hash, hashpwsalt(changes.password))
            _->
                changeset    
        end       
    end
end