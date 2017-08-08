defmodule Plugapi.Task do
    use Ecto.Schema
    import Ecto.Changeset
    alias Plugapi.Task
    
    @derive {Poison.Encoder, only: [:id, :user_id, :title, :body, :priority]}

    schema "tasks" do
        field :user_id, :integer
        field :title, :string
        field :body, :string
        field :priority, :integer     
    end

    #changeset...this is where we validate data
    #cast - defines list of columns allowed
    # changeset(model, params)
   def changeset(%Task{} = task, attrs) do
        task
        |> cast(attrs, [:user_id, :title,:body,:priority])
        |> validate_required([:user_id, :title,:body,:priority])          
    end
end