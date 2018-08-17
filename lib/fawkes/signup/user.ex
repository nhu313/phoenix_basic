defmodule Fawkes.Signup.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt

  @type t :: %__MODULE__{}

  @spec changeset(t, map) :: Ecto.Changeset.t
  @spec registration_changeset(t, map) :: Ecto.Changeset.t

  @bad_passwords ~w(
    12345678
    123456789
    1234567890
    18atcskd2w
    1q2w3e4r
    1q2w3e4r5t
    3rjs1la7qe
    987654321
    adobe123[a]
    asdfghjkl
    asdfghjkl;'
    fawkes123
    password1
    photoshop[a]
    qwertyuiop
    qwertyuiop[]
    zxcvbnm,./
  )

  schema "users" do
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password])
  end

  @doc false
  def registration_changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> validate_exclusion(:password,
                          @bad_passwords,
                          message: "That password is too common.")
    |> validate_length(:password, min: 8)
    |> put_pass_hash()
    |> unique_constraint(:username)
  end

  @spec put_pass_hash(Ecto.Changeset.t) :: Ecto.Changeset.t
  defp put_pass_hash(
    %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
  ) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end
  defp put_pass_hash(changeset), do: changeset
end
