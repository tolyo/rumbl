defmodule Rumbl.User do
  use Rumbl.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :videos, Rumbl.Video
    has_many :annotations, Rumbl.Annotation
    timestamps
  end

  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, ~w(name username))
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
      case changeset do
          %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
              put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
          _ -> changeset
      end
  end
end
